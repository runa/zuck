module Zuck
  require "digest/md5"
  class CustomAudience < RawFbObject
    known_keys :id,
               :name,
               :subtype, 
               :rule,
               :description,
               :opt_out_link,
               :retention_days


    parent_object :ad_account
    list_path     :customaudiences


    def emails=(emails)
      emails = Array(emails)
      audience = emails.map{|email|
        Digest::SHA256.hexdigest(email)
      }
      add_users(audience, "EMAIL_SHA256")
    end

    alias :<< :emails= 

    def add_users(audience, hash_type)
      create_connection(graph, self.id, :users, payload: {data: audience, schema: hash_type}.to_json)
    end

    def share(custom_graph=nil, destination_account_ids:)
      destination_account_ids = Array(destination_account_ids)
      (custom_graph || graph).put_connections(self.id, "adaccounts", adaccounts: destination_account_ids.to_json)
    end

  end
end
