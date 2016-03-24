module Zuck
  class AdCampaign < RawFbObject

    # Known keys as per
    # the [fb docs](https://developers.facebook.com/docs/reference/ads-api/adcampaign/v2.2)
    # as well as undocumented keys returned by the Graph API
    known_keys :id,
               :account_id,
               :name,
               :ads

    parent_object :ad_account, as: :account_id
    list_path     :adcampaign_groups
    connections   :ad_groups, :ad_campaigns

  end
end
