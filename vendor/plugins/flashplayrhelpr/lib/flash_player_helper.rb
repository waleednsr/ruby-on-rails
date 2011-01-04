# Copyright (c) 2006 Farooq Ali
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

module GotRuby
  module FlashPlayerHelper
    
    DEFAULT_PLAYER_OPTIONS = { :enablejs => true } unless const_defined?('DEFAULT_PLAYER_OPTIONS')
  
    DEFAULT_FLASH_OPTIONS = {   :width => 300,
                                :height => 300,
                                :majorversion => 8,
                                :build => 0,
                                :id => 'flash_player',
                                :allowscriptaccess => 'always',
                                :movie => '/mp3player.swf' } unless const_defined?('DEFAULT_FLASH_OPTIONS')
                                
    DEFAULT_MOVIE_LOCATIONS = { :media_player => '/swf/mediaplayer.swf',
                                :mp3_player => '/swf/mp3player.swf',
                                :image_slideshow => '/swf/imagerotator.swf',
                                :flv_player => '/swf/flvplayer.swf' } unless const_defined?('DEFAULT_MOVIE_LOCATIONS')
                                
    FLASH_REQUIRED_MESSAGE = "You need a <a href='http://www.flash.com'>Flash</a> plugin to view this player" unless const_defined?('FLASH_REQUIRED_MESSAGE')
    
    #plays all media that the client's flash can play (mp3, mpeg, flv, jpeg, whatever)
    #looks like windoze media player
    def media_player(player_options = {}, flash_options = {})
      flash_options[:movie] ||= DEFAULT_MOVIE_LOCATIONS[:media_player]
      player player_options, flash_options
    end
    
    #looks like winamp
    def mp3_player(player_options = {}, flash_options = {})
      flash_options[:movie] ||= DEFAULT_MOVIE_LOCATIONS[:mp3_player]
      player player_options, flash_options
    end
    
    def image_slideshow(player_options = {}, flash_options = {})
      flash_options[:movie] ||= DEFAULT_MOVIE_LOCATIONS[:image_slideshow]
      player player_options, flash_options
    end
    
    #plays flash videos
    def flv_player(player_options = {}, flash_options = {})
      flash_options[:movie] ||= DEFAULT_MOVIE_LOCATIONS[:flv_player]
      player player_options, flash_options
    end
    
    #generic flash player helper method
    def player(player_options = {}, flash_options = {})
      player_options = DEFAULT_PLAYER_OPTIONS.dup.update(player_options)
      default_flash_options = DEFAULT_FLASH_OPTIONS.dup
      flash_options = default_flash_options.update(flash_options)
      flash_options.update(:flashvars => hash_to_flash_vars(player_options))
      
      out = content_tag 'div', FLASH_REQUIRED_MESSAGE, :id => "#{flash_options[:id]}_container"
      out << javascript_tag("UFO.create(#{hash_to_ufo_options flash_options}, \"#{flash_options[:id]}_container\");")
    end
    
    def player_event(action, *args)
      if args.last.is_a? Hash then
        id = args.pop[:id].to_s
      end
      id ||= DEFAULT_FLASH_OPTIONS[:id]
      params = ([action]+args).collect{|p| p.is_a?(Numeric)? p : "\"#{p}\""}
      "$(\"#{id}\").sendEvent(#{params.join(',')});"
    end
    
    protected
    
    def hash_to_flash_vars options
      options.collect{|k,v| "#{k}=#{CGI::escape(v.to_s)}"}.join '&'
    end
    
    def hash_to_ufo_options options
      js = '{' + options.collect{|k,v| "#{k}:\"#{v}\""}.join(', ') + '}'
      #aka options_for_javascript :P
    end
  end
end