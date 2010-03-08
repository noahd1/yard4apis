yard4apispath = File.expand_path(File.dirname(__FILE__) + "/lib/")
$LOAD_PATH.unshift(yard4apispath) unless $LOAD_PATH.include?(yard4apispath)
require 'yard_extensions'