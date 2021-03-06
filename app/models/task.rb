require 'auditlog/model_tracker'

class Task < ActiveRecord::Base
  include Auditlog::ModelTracker
  track only: [:title, :hours_estimated, :assigned_to_id], meta: [:project_id]
  attr_accessible :title, :hours_estimated, :assigned_to_id, :percent_completed

  include TaskPermission
  include Workflow

  belongs_to :project, inverse_of: :tasks
  belongs_to :story, :touch => true, inverse_of: :tasks
  belongs_to :assigned_to, :class_name => "User", :foreign_key => "assigned_to_id"
  has_many :time_entries, :as => :trackable

  scope :assigned_to, lambda { |user| where(assigned_to_id: user.id) }
  scope :in_progress, lambda { where(status: 'in_progress') }

  before_create :set_project_id
  after_save :update_story_status, :propagate_values_to_story
  after_destroy :update_story_status, :propagate_values_to_story

  workflow_column :status
  workflow do
    state :open do
      event :start, :transitions_to => :in_progress
    end
    state :in_progress do
      event :finish, :transitions_to => :finished
    end
    state :finished do
      event :qa_approve, :transitions_to => :qa_approved
      event :reopen, :transitions_to => :open
    end
    state :qa_approved do
      event :deploy, :transitions_to => :deployed
    end
    state :deployed do
      event :close, :transitions_to => :closed
      event :reopen, :transitions_to => :open
    end
    state :closed do
      event :reopen, :transitions_to => :open
    end

    on_transition do |from, to, triggering_event, *event_args|
      self.touch
    end
  end

  def total_hours_spent
    time_entries.sum('hours_spent')
  end

  def time_entry_for(user, date)
    time_entries.spent_on(date).by(user).first
  end

  def total_hours_spent_on(date)
    time_entries.spent_on(date).by(assigned_to).sum('hours_spent')
  end

  def enter_time(user, date, hours_spent, percent_completed)
    time_entry = self.time_entries.spent_on(date).by(user).first_or_initialize
    time_entry.hours_spent = hours_spent
    time_entry.percent_completed = percent_completed
    time_entry.milestone_id = self.story.milestone_id
    time_entry.save!
    time_entry
  end

  def propagate_hours_spent
    story.propagate_hours_spent if self.hours_spent_changed?
  end

  def propagate_hours_estimated
    story.propagate_hours_estimated if self.hours_estimated_changed?
  end

  def propagate_percent_completed
    # fire if only the percent_completed changed
    story.propagate_percent_completed if self.percent_completed_changed? and !self.hours_estimated_changed?
  end

  private

  #not yet implemented
  def update_story_status
    story.update_status
  end

  def propagate_values_to_story
    propagate_hours_spent
    propagate_hours_estimated
    propagate_percent_completed
  end

  def set_project_id
    self.project_id = self.story.project_id
  end

end