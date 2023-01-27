class FirestoreService
  class << self
    def client
      @client ||= Google::Cloud::Firestore.new
    end

    def collection(name)
      client.col(name)
    end

    def document(name)
      client.doc(name)
    end

    def get_document(name)
      document(name).get
    end

    def get_collection(name)
      collection(name).get
    end

    def create_document(name, data)
      document(name).create(data)
    end

    def update_document(name, data)
      document(name).update(data)
    end

    def delete_document(name)
      document(name).delete
    end
  end
end
