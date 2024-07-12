{ config, pkgs, ... }:

{
  systemd.user.services.createTemplateDocs = {
    description = "Create common documents in Templates folder";
    script = ''
      #!/bin/bash
      # Tolga Erok
      # 10-6-2024
      # create common doc's in Template folder in home

      # Define the template directory
      TEMPLATE_DIR="$HOME/Templates"

      # Create the template directory if it doesn't exist
      mkdir -p "$TEMPLATE_DIR"

      # Create blank text document
      touch "$TEMPLATE_DIR/Document.txt"

      # Create blank Word document
      touch "$TEMPLATE_DIR/Document.docx"

      # Create blank Excel spreadsheet
      touch "$TEMPLATE_DIR/Spreadsheet.xlsx"

      # Create blank configuration file
      touch "$TEMPLATE_DIR/Config.conf"

      # Create blank markdown file
      touch "$TEMPLATE_DIR/Document.md"

      # Create blank shell script
      touch "$TEMPLATE_DIR/Script.sh"

      # Create blank Python script
      touch "$TEMPLATE_DIR/Script.py"

      # Create blank JSON file
      touch "$TEMPLATE_DIR/Document.json"

      # Create blank YAML file
      touch "$TEMPLATE_DIR/Document.yaml"

      # Create blank HTML file
      touch "$TEMPLATE_DIR/Document.html"

      # Create blank CSS file
      touch "$TEMPLATE_DIR/Document.css"

      # Create blank JavaScript file
      touch "$TEMPLATE_DIR/Document.js"

      # Print a message indicating completion
      echo "Template documents created in $TEMPLATE_DIR"
    '';
    wantedBy = [ "default.target" ];
    enable = true;
  };
}
