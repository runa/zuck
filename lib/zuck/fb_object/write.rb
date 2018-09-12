module Zuck
 module FbObject
   module Write
    def self.included(base)
      base.extend(ClassMethods)
    end

    def save
      self.class.raise_if_read_only

      # Tell facebook to return
      data = @hash_delegator_hash
      data = data.stringify_keys

      # Don't post ids, because facebook doesn't like it
      data = data.keep_if{ |k,v| k != "id" }

      # Update on facebook
      result = post(graph, path, data)

      reload
      result["result"]
    end

    def destroy
      self.class.destroy(graph, path)
    end


    module ClassMethods

      def raise_if_read_only
        return unless read_only?
        raise Zuck::Error::ReadOnly.new("#{self} is read_only")
      end

      def create(graph, data, parent=nil, path=nil)
        raise_if_read_only
        p = path || parent.path

        # We want facebook to return the data of the created object

        # Create
        result = create_connection(graph, p, list_path, data)

        # If the redownload flag was supported, the data is nested by
        # name and id, e.g.
        #
        #     "campaigns" => { "12345" => "data" }
        #
        # Since we only create one at a time, we can just say:
        if d=result['data']
          data = d.values.first.values.first

        # Redownload was not supported, in this case facebook returns
        # just {"id": "12345"}
        elsif result['id']
          data = result

        # Don't know what to do. No id and no data. I need an adult.
        else
          raise "Invalid response received, found neither a data nor id key in #{result}"
        end

        # Return a new instance
        ret = new(graph, data, parent)
        ret.reload if data["id"]
        ret
      end

      def destroy(graph, id)
        raise_if_read_only
        delete(graph, id)
      end

    end

   end
 end
end
