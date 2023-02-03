#
# Simple interface to Firestore database and commonly used data
#
class FirestoreService
  class << self
    def client
      @client ||= Google::Cloud::Firestore.new
    end

    # Returns Google::Cloud::Firestore::CollectionReference for the Players collection
    # If you provide a league, the collection will be scoped to that league
    # Otherwise, they will be returned nested under the league
    def players(league = nil)
      client.col "players#{"/#{league}" if league}"
    end
  end

  #
  # Interface with the Drafts collection in Firebase
  #
  class Drafts
    class << self
      # Returns Google::Cloud::Firestore::CollectionReference for the Drafts collection
      def all
        FirestoreService.client.col 'drafts'
      end

      # Returns Google::Cloud::Firestore::DocumentReference for the given draft id
      def reference(id)
        all.doc id
      end

      # Returns Google::Cloud::Firestore::DocumentSnapshot for the given draft id
      def document(id)
        reference(id).get
      end

      # Alias for #document
      def snapshot(id)
        document(id)
      end

      # Returns Array of hashes representing the draft state, with all keys as integers
      def state(id)
        document(id)[:state].deep_transform_keys { |k| k.to_s.to_i }
      end

      # Set pick within draft state by round and pick number
      def set_pick!(opts)
        state = state(opts[:draft_id])
        pick = state[opts[:round]][opts[:pick_number] - 1]
        pick[opts[:fantasy_team_id]] = opts[:player_id]
        set_state!(opts[:draft_id], state)
      end

      # Sets the draft state for the given draft id
      # Returns Google::Cloud::Firestore::CommitResponse::WriteResult
      def set_state!(id, state)
        reference(id).set({ state: })
      end
    end
  end
end
