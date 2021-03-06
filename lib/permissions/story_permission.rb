module StoryPermission
	def permitted_to_edit_by?(user)
		user.admin_for?(project) || self.assigned_to == user || self.not_started?
	end

	def permitted_to_delete_by?(user)
		user.admin_for?(project) || self.assigned_to == user
	end
end