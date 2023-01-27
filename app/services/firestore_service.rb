class FirestoreService
  class << self
    def client
      @client ||= Google::Cloud::Firestore.new
    end

    def drafts
      client.col 'drafts'
    end

    def draft_reference(id)
      drafts.doc id
    end

    def draft_document(id)
      draft_reference(id).get
    end

    def draft_state(id)
      draft_document(id)[:state]
    end

    def set_draft_state!(id, state)
      draft_reference(id).set({ state: })
    end
  end
end
