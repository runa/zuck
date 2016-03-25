require 'zuck/facebook/ad_creative'

module Zuck
  class AdGroup < RawFbObject

    # Known keys as per
    # [fb docs](https://developers.facebook.com/docs/reference/ads-api/adgroup/v2.2)
    known_keys :id,
               :account_id,
               :conversion_specs,
               :adset_id,
               :created_time,
               :failed_delivery_checks,
               :name,
               :tracking_specs,
               :updated_time,
               :status
               # app must be whitelisted to use view_tags
               # :view_tags

    parent_object :ad_campaign
    list_path     :ads
    connections   :ad_creatives

    def self.create(graph, data, ad_set)
      path = ad_set.ad_account.path
      data[:adset_id] = ad_set.id
      super(graph, data, ad_set, path)
    end

    def status
      data[:adgroup_status] || data[:status]
    end

  end
end
