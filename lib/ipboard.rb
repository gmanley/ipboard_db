# Field name clarity over brevity for documentation purposes
module Ipboard
  module BaseModel
    def self.included(base)
      base.send(:include, DataMapper::Resource)
      # Kinda hacky :\
      storage_name = base.storage_name.gsub("#{base.parent_name.downcase}_", '')
      base.storage_names[:default] = storage_name
    end
  end

  class Forum
    include BaseModel

    has n, :topics

    property :id, Serial
    # property :topic_count, Integer, field: 'topics'
    # property :post_count, Integer, field: 'posts'
    # property :last_post_id, Integer, field: 'last_post'
    # property :last_post_by_id, Integer, field: 'last_poster_id'
    # property :last_post_by_name, String, field: 'last_poster_name'
    property :title, String, field: 'name'
    property :description, Text
    property :position, Integer
    # property :use_ibc, Boolean # ???
    # property :html_enabled, Boolean, field: 'use_html'
    property :password, String
    property :password_required, String, field: 'password_override' # Comma seperated values of groups not required to have password
    # property :last_modified_topic_title, String, field: 'last_title'
    # property :last_modified_topic_id, Integer, field: 'last_id'
    # property :topic_sort_by, String, field: 'sort_key'
    # property :topic_sort_direction, String, field: 'sort_order'
    # property :topic_per_page, Integer, field: 'prune'
    # property :topic_filter, String, field: 'topicfilter' # This is set to 'all' for all ssf topics
    # property :show_rules, Integer # null, 0 or 2 ???
    # property :require_post_review, Boolean, field: 'preview_posts' # If mods must approve before post? all 0 for ssf - still used??
    # property :allow_poll, Boolean
    # property :allow_poll_bump, Boolean, field: 'allow_pollbump' # All 0 for ssf - still used?
    property :increments_post_count, Boolean, field: 'inc_postcount' # If posting in forum will cause user post_count to be incremented
    # property :skin_id, Integer # 0 or null for newly created forums - Probably not used anymore
    property :parent_id, Integer # -1 for root forums otherwise id of parent forum
    property :redirect_url, String # URL this forum link redirects to
    property :redirect_enabled, Boolean, field: 'redirect_on'
    property :redirect_hit_count, Integer, field: 'redirect_hits'
    property :rules_title, String
    property :rules_text, Text
    # property :mod_emails_on_queued, Text, field: 'notify_modq_emails' # List of emails to notify on queued post/topic? 0 or empty string SSF - still used?
    property :allows_topics, Boolean, field: 'sub_can_post' # If can post topics or only category forum
    property :permission_denied_text, Text, field: 'permission_custom_error'
    property :permission_denied_show_topics, Boolean, field: 'permission_showtopic' # Show topics but no posts if no permission?
    # property :queued_topic_count, Integer, field: 'queued_topics'
    # property :queued_post_count, Integer, field: 'queued_posts'
    # property :ratings_enabled, Boolean, field: 'forum_allow_rating'
    # property :last_deletion_at, EpochTime, field: 'forum_last_deletion' # Just topics? posts too?
    # property :last_topic_title, String, field: 'newest_title'
    # property :last_topic_id, Integer, field: 'newest_id' # -_- ipb
    # property :can_view_others, Boolean # ??? all 1 on SSF - Still used?
    property :min_post_count_to_post, Integer, field: 'min_posts_post'
    property :min_post_count_to_view, Integer, field: 'min_posts_view'
    #! property :hidden_last_topic, Boolean, field: 'hide_last_info' # Normally last topic info is displayed on forum list page regardless of permissions this disables that.
    # property :title_slug, String, field: 'name_seo'
    # property :last_topic_slug, String, field: 'seo_last_title'
    # property :last_post_by_slug, String, field: 'seo_last_name'
    # property :last_topic_ids_created_at_map, SerializedPHP, field: 'last_x_topic_ids'
    #! property :options_bit, Integer, field: 'forums_bitoptions' # ???
    property :character_requirement, Boolean, field: 'f_chars_limitation' # If character requirement is enabled (Min post)
    # property :share_links_disabled, Boolean, field: 'disable_sharelinks'
    # property :deleted_post_count, Integer, field: 'deleted_posts'
    # property :deleted_topic_count, Integer, field: 'deleted_topics'
    property :predefined_tags, Text, field: 'tag_predefined' # Comma seperated value
    property :newest_prefix, String # Not used on ssf
    property :require_prefix, Boolean # Not used on ssf
    property :default_prefix, String # not used on ssf
    property :default_tags, Text # not used on ssf
    property :tag_mode, String # Only 'inherit' on ssf
    property :show_prefix_in_description, Boolean, field: 'show_prefix_in_desc' # not used on ssf
    property :min_character_count, Integer, field: 'f_num_chars'
    property :min_word_count, Integer, field: 'f_num_words'
    # property :archived_topic_count, Integer, field: 'archived_topics'
    # property :archived_post_count, Integer, field: 'archived_posts'
    property :min_post_count, Integer, field: 'f_num_posts'
    property :min_topic_count, Integer, field: 'f_num_threads'
    property :min_daily_posts, Integer, field: 'f_daily_posts'
    property :min_days_as_member, Integer, field: 'f_reg_days'
    property :min_like_count, Integer, field: 'f_num_likes'
    property :min_age, Integer, field: 'f_age'
    # property :viglink, Boolean # ??
    # property :seo_priority, String, field: 'ipseo_priority' # ???
  end

  class Topic
    include BaseModel

    belongs_to :created_by, 'Member'
    belongs_to :last_post_by, 'Member'
    belongs_to :last_post, 'Post'
    belongs_to :first_post, 'Post'
    belongs_to :new_topic, 'Topic'
    # belongs_to :last_vote, 'Vote'
    belongs_to :forum

    has n, :posts

    property :id, Serial, field: 'tid'
    property :title, String
    property :description, String
    property :state, String
    property :post_count, Integer, field: 'posts'
    property :created_by_id, Integer, field: 'starter_id'
    property :created_at, EpochTime, field: 'start_date'
    property :last_post_by_id, Integer, field: 'last_poster_id'
    property :last_post_id, Integer, field: 'last_post'
    property :icon_id, Integer # Still used?
    property :created_by_name, String, field: 'starter_name'
    property :last_post_by_name, String, field: 'last_poster_name'
    property :poll_state, String
    property :last_vote_id, Integer, field: 'last_vote'
    property :view_count, Integer, field: 'views'
    property :forum_id, Integer
    property :approved, Integer # -1, 0 or 1 ???? what's -1!?
    property :author_mode, Integer # 1 or null ??? what does it mean!?
    property :pinned, Boolean
    property :new_topic_id, Integer, field: 'moved_to'
    property :has_attachments, Boolean, field: 'topic_hasattach'
    property :first_post_id, Integer, field: 'topic_firstpost'
    property :queued_post_count, Integer, field: 'topic_queuedposts'
    property :open_at, EpochTime, field: 'topic_open_time'
    property :close_at, EpochTime, field: 'topic_close_time'
    property :rating_total, Integer, field: 'topic_rating_total'
    property :rate_count, Integer, field: 'topic_rating_hits'
    property :title_slug, String, field: 'title_seo'
    property :last_post_by_slug, String, field: 'seo_last_name'
    property :started_by_slug, String, field: 'seo_first_name'
    property :deleted_post_count, Integer, field: 'topic_deleted_posts'
    property :deleted_at, EpochTime, field: 'tdelete_time'
    property :moved_at, EpochTime, field: 'moved_on'
    property :last_real_post_id, Integer, field: 'last_real_post' # WTF is a "real" post?!
    property :archive_status, Integer, field: 'topic_archive_status' # Probably a bool but we don't use archiving so we just have 0
    property :answered_by_post_id, Integer, field: 'topic_answered_pid'
  end

  class Post
    include BaseModel

    belongs_to :created_by, 'Member'#, child_key: 'author_id'
    belongs_to :topic

    property :id, Serial, field: 'pid'
    property :show_edit_info, Boolean, field: 'append_edit'
    property :edited_at, EpochTime, field: 'edit_time'
    property :created_by_id, Integer, field: 'author_id'
    property :created_by_name, String, field: 'author_name'
    property :show_signature, Boolean, field: 'use_sig'
    property :show_emoticons, Boolean, field: 'use_emo'
    property :ip_address, String # TODO: Rename to specify who's ip address?
    property :created_at, EpochTime, field: 'post_date'
    property :icon_id, Integer # Still used?
    property :content, Text, field: 'post'
    property :queued, Integer # 0, 1, 2 or 3 --- what do they mean?!
    property :topic_id, Integer
    property :title, String, field: 'post_title' # Used? check if any non blank
    property :first_post, Boolean, field: 'new_topic'
    property :edited_by_name, String, field: 'edit_name'
    property :cache_key, String, field: 'post_key' # UUID of some sort probably for caching
    property :html_state, Integer, field: 'post_htmlstate' # 0, 1 or 2 -- what do they mean?!
    property :edit_reason, String, field: 'post_edit_reason'
    property :bwoptions, Integer, field: 'post_bwoptions' # 0 or 1 boolean? -- what does it mean ???
    property :deleted_at, EpochTime, field: 'pdelete_time'
  end

  class Member
    include BaseModel

    has 1, :profile
    has n, :topics, child_key: 'starter_id'
    has n, :posts, child_key: 'created_by_id'

    property :id, Serial, field: 'member_id'
    property :name, String
    property :email, String
    property :display_name, String, field: 'members_display_name'
    property :day_of_birth, Integer, field: 'bday_day'
    property :month_of_birth, Integer, field: 'bday_month'
    property :year_of_birth, Integer, field: 'bday_year'

    def birthday
      birthday_components = [year_of_birth, month_of_birth, day_of_birth]
      unless birthday_components.include?(0) || !birthday_components.all?
        Date.new(*birthday_components)
      end
    end

    def age
      if birthday
        now = Date.today
        now.year - birthday.year - ((now.month > birthday.month || (now.month == birthday.month && now.day >= birthday.day)) ? 0 : 1)
      end
    end
  end

  class Profile
    include BaseModel

    storage_names[:default] = "pfields_content"

    belongs_to :member

    property :member_id, Serial
    property :country, String, field: 'field_2'
  end
end
