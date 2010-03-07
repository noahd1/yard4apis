module Api
  class FriendshipsController < ApplicationController

    # Check which of the specified user ids represent friends of the target member
    #
    # @parameter member_id (required) The target member's ID
    # @parameter user_ids (required) array of IDs of users to determine whether the target member is friends with 
    # @returns Set of friend_ids and pending_ids which represent friends of the target member and friends the target member has requested
    #
    # @authenticated false
    # @formats xml, json
    def check
    end
    
  end
end
