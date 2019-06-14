#!/usr/bin/env bash

echo "=> Php"


DIR=$(echo /usr/local/etc/php/7.1)
CONFIG=$(echo $DIR/php.ini)
TIMEZONE=$(echo $(cut -d ":" -f 2 <<< $(sudo systemsetup -gettimezone) | xargs))


mkdir -p ~/workspace/www


print_info "Making a file to display phpinfo..."

if [ ! -f "$HOME/workspace/www/info.php" ]
then
  echo "<?php phpinfo();" > "$HOME/workspace/www/info.php"
  print_success "Completed..."
else
  print_success "Skipping..."
fi


print_info "Configuring..."

if ! grep -Fxq "$CONFIGURED_MESSAGE" "$CONFIG"
then
  modify_file "[PHP]" "; $CONFIGURED_MESSAGE" "/usr/local/etc/php/7.2/php.ini"
  modify_line ';date.timezone =' "date.timezone = $TIMEZONE" "$CONFIG"
  modify_line 'post_max_size = 8M' 'post_max_size = 25M' "$CONFIG"
  modify_line 'upload_max_filesize = 2M' 'upload_max_filesize = 20M' "$CONFIG"

  print_success "Completed..."
else
  print_success "Skipping..."
fi
