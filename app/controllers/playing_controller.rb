# frozen_string_literal: true

# BigBlueButton open source conferencing system - http://www.bigbluebutton.org/.
#
# Copyright (c) 2018 BigBlueButton Inc. and by respective authors (see below).
#
# This program is free software; you can redistribute it and/or modify it under the
# terms of the GNU Lesser General Public License as published by the Free Software
# Foundation; either version 3.0 of the License, or (at your option) any later
# version.
#
# BigBlueButton is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License along
# with BigBlueButton; if not, see <http://www.gnu.org/licenses/>.

class PlayingController < ApplicationController
  
  def playback
    return redirect_to root_path unless current_user
    log_info("Recording: #{current_user.email} play: #{params["tkn"]}")
    @meet_id = params["tkn"]
    return redirect_to root_path unless @meet_id
    redirect_to "#{ENV['MEDIA_SERVER_LINK']}/playback/#{@meet_id}"
    # render "playing/playback", :layout => false
  end

  def get_log_tag()
    return "[#{request.env["HTTP_X_FORWARDED_FOR"]}] [#{@current_user.email}]" unless @current_user.nil?
    "[#{request.env["HTTP_X_FORWARDED_FOR"]}]"
  end

  def log_error(msg)
    logger.error "#{get_log_tag}: #{msg}"
  end

  def log_info(msg)
    logger.info "#{get_log_tag}: #{msg}"
  end

end
