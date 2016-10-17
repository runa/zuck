module Zuck
  class AdCreative < RawFbObject

    # Known keys as per
    # [fb docs](https://developers.facebook.com/docs/reference/ads-api/adaccount/)
    known_keys :body,
               :call_to_action_type,
               :image_crops,
               :image_file,
               :image_hash,
               :image_url,
               :link_url,
               :name,
               :object_id,
               :object_story_id,
               :object_story_spec,
               :object_url,
               :title,
               :url_tags,
               :multi_share_optimized,
               :id

    parent_object :ad_group
    list_path     :adcreatives

  end
end
