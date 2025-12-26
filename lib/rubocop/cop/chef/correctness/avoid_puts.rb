# frozen_string_literal: true

module RuboCop
  module Cop
    module Chef
      module Correctness
        
        class AvoidPuts < Base
          
          extend AutoCorrector

          MSG = 'Do not use puts in Chef recipes. Use the log resource or Chef::Log instead.'

          def on_send(node)
            return unless node.method_name == :puts
            
            add_offense(node) do |corrector|
              
              corrector.replace(node.loc.selector, 'log')
            end
          end
        end
      end
    end
  end
end