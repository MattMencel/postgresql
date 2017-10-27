# frozen_string_literal: true
#
# Cookbook:: postgresql
# Resource:: install
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

property :version, String, default: '9.6'
property :enable_pgdg, [true, false], default: true
property :enable_pgdg_source, [true, false], default: false
property :enable_pgdg_updates_testing, [true, false], default: false
property :enable_pgdg_source_updates_testing, [true, false], default: false
property :yum_gpg_key_uri, [String, nil], default: nil
property :apt_gpg_key_uri, [String, nil], default: nil

action :install do
  postgresql_repository 'Add downloads.postgresql.org repository' do
    version new_resource.version
    enable_pgdg new_resource.enable_pgdg
    enable_pgdg_source new_resource.enable_pgdg_source
    enable_pgdg_updates_testing new_resource.enable_pgdg_updates_testing
    enable_pgdg_source_updates_testing new_resource.enable_pgdg_source_updates_testing
    yum_gpg_key_uri new_resource.yum_gpg_key_uri unless new_resource.yum_gpg_key_uri.nil?
    apt_gpg_key_uri new_resource.yum_gpg_key_uri unless new_resource.yum_gpg_key_uri.nil?
  end

  case node['platform_family']
  when 'debian'
    package 'postgresql-client'
  when 'rhel'
    package "postgresql#{new_resource.version}"
  end
end
