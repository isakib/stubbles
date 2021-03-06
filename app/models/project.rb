class Project < ActiveRecord::Base
  attr_accessible :name, :creator, :description, :started_on, :sprint_length

  include ProjectPermission
  HOURS_PER_DAY = 8

  has_many :stories, inverse_of: :project
  has_many :tasks, inverse_of: :project
  has_many :milestones, inverse_of: :project
  has_many :memberships, :class_name => 'ProjectMembership'
  has_many :users, :through => :memberships, :source => :user
  belongs_to :creator, :class_name => 'User', :readonly => :true

  validates :creator_id, presence: true
  validates :name, presence: true

  after_create :add_creator_as_project_admin

  def collaborators
    self.users.where("(project_memberships.role = ? OR project_memberships.role = ?) 
                        AND project_memberships.active = ?", Role::ADMIN, Role::MEMBER, true)
  end

  def membership_of(user)
    self.memberships.active.where(:user_id => user).first
  end

  def move_stories_to_milestone(milestone_id, story_ids)
    stories = self.stories.find(story_ids)
    stories.each do |story|
      story.update_attribute(:milestone_id, milestone_id)
    end
    stories
  end

  def current_sprint
    self.milestones.current_sprints.first
  end

  private

  def add_creator_as_project_admin
    self.memberships.create(:user_id => creator.id, :role => Role::ADMIN)
  end

end