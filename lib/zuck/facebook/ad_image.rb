module Zuck
  class AdImage < RawFbObject

    # Known keys as per
    # [fb docs](https://developers.facebook.com/docs/reference/ads-api/adaccount/)
    known_keys :hash,
               :url,
               :creatives,
               :width,
               :height,
               :original_width,
               :original_height

    parent_object :ad_account
    list_path     :adimages

    def self.copy_from(destination_account_id: nil, destination_account: nil, source_account: nil, source_account_id: nil, hash:)
      src_id = (source_account.try(:id) || source_account_id).to_s.gsub("act_","")
      dst_id = (destination_account.try(:id) || destination_account_id).to_s.gsub("act_","")
      raise "Missing source_account[_id]" if not src_id
      raise "Missing destination_account[_id]" if not dst_id



      Zuck.graph.put_connections("/act_#{dst_id}", "adimages", copy_from: {source_account_id: src_id.to_s, hash: hash}.to_json)
    end
  end
end
