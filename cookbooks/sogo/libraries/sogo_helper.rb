#
# Cookbook Name:: sogo
# Library:: sogo_helper
#
# Copyright 2014, OpenSinergia
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# see Travis Carona's comment at https://sethvargo.com/using-gems-with-chef/
begin
  gem "deep_merge"
rescue LoadError
  system("gem install --no-rdoc --no-ri deep_merge")
  Gem.clear_paths
end

require 'json'
require 'deep_merge'

module Sogo
  module Helper

    def build_items(current_element, answer, depth_level)
      current_element.class == Hash && current_element.each { |k,v|
        if v.class == String
          answer << '  ' * depth_level + k + ' = "' + v + '";'
        elsif v.class == TrueClass
          answer << '  ' * depth_level + k + ' = ' + "YES" + ';'
        elsif v.class == FalseClass
          answer << '  ' * depth_level + k + ' = ' + "NO" + ';'
        elsif v.class == Hash
          answer << '  ' * depth_level + k + " = {"
          build_items(v, answer, depth_level + 1)
          answer << '  ' * depth_level + "};"
        elsif v.class == Array
          answer << '  ' * depth_level + k + " = ("
          v.each_index { |i|
            if v[i].class == Hash
              answer << '  ' * (depth_level + 1) + "{"
              build_items(v[i], answer, depth_level + 2)
              answer << '  ' * (depth_level + 1) + "}"
            else
              build_items(v[i], answer, depth_level + 1)
            end
            answer << '  ' * (depth_level + 1) + "," if i < v.size - 1
          }
          answer << '  ' * depth_level + ");"
        end
      }
      # for cases like "uid" and "mail" when present in
      # a JSON array like this: "bindFields": ["uid", "mail"]
      if current_element.class == String
        answer << '  ' * depth_level + '"' + current_element + '"'
      end
    end

    # merge two strings containing json formatted data of sogo config.
    # first string is the base config, second string is more specific
    # and takes precedence
    def merge_json_to_hash(base_json, specific_json)
      return JSON.parse(base_json) if specific_json.nil? || specific_json.empty?
      merged_hash = JSON.parse(specific_json).deep_merge(JSON.parse(base_json))
      # possibly, the specific json may exclude some config parameter
      # included by the base config
      merged_hash.delete_if { |k,v| v.class == String && v.empty? }
      return merged_hash
    end

    def generate_plist(final_hash)
      answer = Array.new
      build_items(final_hash, answer, 1)
      answer
    end
  end
end
