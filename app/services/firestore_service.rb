#
# Simple interface to Firestore database and commonly used data
#
class FirestoreService
  class << self
    def client
      @client ||= Google::Cloud::Firestore.new
    end
  end

  #
  # Interface with the Players collection in Firebase
  #
  class Players
    class << self
      # Returns Google::Cloud::Firestore::CollectionReference for the Players collection
      def all
        FirestoreService.client.col 'players'
      end

      def player_reference(player_id)
        all.doc(player_id)
      end

      def player_snapshot(player_id)
        player_reference(player_id).get
      end

      # adds a player document, with the player's ID being the document ID
      # will overwrite the document if it already exists
      def add_player!(player)
        puts "Adding #{player.full_name} to Firestore `players` collection"
        player_document(player.id).set(player.attributes_without_data, merge: false)
      end

      # add a document for each player, with their ID being the document ID
      # allows for a league to be passed in, which will only add players from that league
      # if no league is passed in, all players will be added
      # checks if player id exists in Firestore before adding, will skip record if it does
      def add_all_players!(league = nil)
        players = league ? Players.by_league(league) : Player.all
        players.each do |player|
          add_player!(player) unless player_snapshot(player.id).exists?
        end
      end

      def update_player!(player)
        player_reference(player.id).update(player.attributes_without_data)
        puts "Updated Document #{player.id}: #{player.full_name} in Firestore `players` collection"
      end

      # updates/overwrites all players in the database
      # allows for a league to be passed in, which will only update players from that league
      # if no league is passed in, all players will be updated
      def update_all_players!(league = nil)
        players = league ? Players.by_league(league) : Player.all
        players.each { |player| update_player!(player) }
      end
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
