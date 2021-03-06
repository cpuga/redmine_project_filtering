module RedmineProjectFiltering
  module Patches
    module ProjectPatch

      def self.included(base)
        base.send(:include, RedmineProjectFiltering::WithCustomValues)
        base.extend ClassMethods
        base.class_eval do
          unloadable
        end
      end
      
      module ClassMethods
        def search_by_question(question)
          if question.length > 1
            search(RedmineProjectFiltering.calculate_tokens(question), nil, :all_words => true).first.sort_by(&:lft)
          else
            all(:order => 'lft')
          end
        end
      end

    end
  end
end
