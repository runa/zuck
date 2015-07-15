require 'zuck/facebook/ad_creative'

module Zuck
  class AdSet < RawFbObject

    # Known keys as per
    # [fb docs](https://developers.facebook.com/docs/reference/ads-api/adset/v2.3)
    known_keys :id,
               :name,
               :account_id,
               :start_time,
               :updated_time,
               :created_time,
               :promoted_object

    parent_object :ad_account, as: :account_id
    list_path     :adcampaigns # Yes, this is correct, "for legacy reasons"
    connections   :ad_groups, :ad_creatives

  end
end
