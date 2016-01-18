# Author:: Adam Edwards (<adamed@chef.io>)
# Cookbook Name:: dsc Resource:: configuration
#
# Copyright:: 2014, Chef Software, Inc.
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

require 'json'

class PowershellCmdletResult
  def initialize(status, output_format)
    @status = status
    @output_format = output_format
  end

  attr_reader :output_format

  def stderr
    @status.stderr
  end

  def return_value
    if output_format == :object
      JSON.parse(@status.stdout)
    else
      @status.stdout
    end
  end

  def succeeded?
    @succeeded = @status.status.exitstatus == 0
  end
end
