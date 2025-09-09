#!/usr/bin/env bash

# Directory containing files
DIR="../target/svg_sprites"
# Output file
OUTPUT="../dist/plantuml-stdlib/stdlib/archimate/ArchimateSprites.puml"

## Duplicate identical SVGs for several types
duplicate_svg() {
  local source="$1"
  shift                 # Shift arguments so that $@ contains the array elements
  local targets=("$@")  # Capture remaining arguments as an array

  for element in "${targets[@]}"; do
    cp $DIR/"$source".svg $DIR/"$element".svg
  done
}

to_kebab_case() {
    local input="$1"
    # Convert to lowercase and replace underscores with dashes
    local output="${input,,}"          # lowercase
    output="${output//_/-}"            # replace underscores with dashes
    echo "$output"
}

# Motivation_Stakeholder serves as template for Role and Business_Role
targets=("Business_Role" "Role" "Stakeholder" "Stakeholder_Filled")
duplicate_svg "Motivation_Stakeholder" "${targets[@]}"

# Other_Location serves as template for Business_Location
targets=("Business_Location")
duplicate_svg "Other_Location" "${targets[@]}"

# Business_Collaboration serves as template for Application_Collaboration and Technology_Collaboration
targets=("Application_Collaboration" "Technology_Collaboration")
duplicate_svg "Business_Collaboration" "${targets[@]}"

# Business_Interface serves as template for Application_Interface and Technology_Interface
targets=("Application_Interface" "Technology_Interface")
duplicate_svg "Business_Interface" "${targets[@]}"

# Business_Process serves as template for Application_Process and Technology_Process
targets=("Application_Process" "Technology_Process")
duplicate_svg "Business_Process" "${targets[@]}"

# Business_Function serves as template for Application_Function and Technology_Function
targets=("Application_Function" "Technology_Function")
duplicate_svg "Business_Function" "${targets[@]}"

# Business_Interaction serves as template for Application_Interaction and Technology_Interaction
targets=("Application_Interaction" "Technology_Interaction")
duplicate_svg "Business_Interaction" "${targets[@]}"

# Business_Event serves as template for Application_Event, Technology_Event, and Implementation_Event
targets=("Application_Event" "Technology_Event" "Implementation_Event")
duplicate_svg "Business_Event" "${targets[@]}"

# Business_Service serves as template for Application_Service and Technology_Service
targets=("Application_Service" "Service" "Technology_Service")
duplicate_svg "Business_Service" "${targets[@]}"

# Business_Object serves as template for Application_DataObject
targets=("Application_DataObject" "Application_Data_Object")
duplicate_svg "Business_Object" "${targets[@]}"

# Also create sprite for element type without category and using old names (backward compatibility)
targets=("Actor")
duplicate_svg "Business_Actor" "${targets[@]}"

targets=("Assessment" "Assessment_Filled")
duplicate_svg "Motivation_Assessment" "${targets[@]}"

targets=("Collaboration")
duplicate_svg "Business_Collaboration" "${targets[@]}"

targets=("Component")
duplicate_svg "Application_Component" "${targets[@]}"

targets=("Communication_Path" "Technology_Communication_Path")
duplicate_svg "Technology_Path" "${targets[@]}"

targets=("Constraint" "Constraint_Filled")
duplicate_svg "Motivation_Constraint" "${targets[@]}"

targets=("Contract")
duplicate_svg "Business_Contract" "${targets[@]}"

targets=("Deliverable" "Deliverable_Filled")
duplicate_svg "Implementation_Deliverable" "${targets[@]}"

targets=("Device")
duplicate_svg "Technology_Device" "${targets[@]}"

targets=("Driver" "Driver_Filled")
duplicate_svg "Motivation_Driver" "${targets[@]}"

targets=("Event")
duplicate_svg "Business_Event" "${targets[@]}"

targets=("Equipment" "Physical_Equipment")
duplicate_svg "Technology_Equipment" "${targets[@]}"

targets=("Facility" "Physical_Facility")
duplicate_svg "Technology_Facility" "${targets[@]}"

targets=("Function")
duplicate_svg "Business_Function" "${targets[@]}"

targets=("Gap" "Gap_Filled")
duplicate_svg "Implementation_Gap" "${targets[@]}"

targets=("Goal" "Goal_Filled")
duplicate_svg "Motivation_Goal" "${targets[@]}"

targets=("Interaction")
duplicate_svg "Business_Interaction" "${targets[@]}"

targets=("Interface")
duplicate_svg "Business_Interface" "${targets[@]}"

targets=("Location")
duplicate_svg "Other_Location" "${targets[@]}"

targets=("Material" "Physical_Material")
duplicate_svg "Technology_Material" "${targets[@]}"

targets=("Meaning")
duplicate_svg "Motivation_Meaning" "${targets[@]}"

targets=("Network" "Technology_Communication_Network")
duplicate_svg "Technology_CommunicationNetwork" "${targets[@]}"

targets=("Node")
duplicate_svg "Technology_Node" "${targets[@]}"

targets=("Object")
duplicate_svg "Business_Object" "${targets[@]}"

targets=("Plateau")
duplicate_svg "Implementation_Plateau" "${targets[@]}"

targets=("Principle" "Principle_Filled")
duplicate_svg "Motivation_Principle" "${targets[@]}"

targets=("Process")
duplicate_svg "Business_Process" "${targets[@]}"

targets=("Product")
duplicate_svg "Business_Product" "${targets[@]}"

targets=("Representation")
duplicate_svg "Business_Representation" "${targets[@]}"

targets=("Requirement" "Requirement_Filled")
duplicate_svg "Motivation_Requirement" "${targets[@]}"

targets=("Strategy_Course_Of_Action")
duplicate_svg "Strategy_CourseOfAction" "${targets[@]}"

targets=("Technology_Distribution_Network")
duplicate_svg "Technology_DistributionNetwork" "${targets[@]}"

targets=("System_Software" "Technology_System_Software")
duplicate_svg "Technology_SystemSoftware" "${targets[@]}"

targets=("Value")
duplicate_svg "Motivation_Value" "${targets[@]}"

targets=("Workpackage" "Workpackage_Filled" )
duplicate_svg "Implementation_WorkPackage" "${targets[@]}"

## Generate sprites for all Archimate types

echo "' Do not edit this file. It is generated by running ./generate_spriteinclude.sh" > "$OUTPUT"
echo "" >> "$OUTPUT"

# Loop through all files in the folder
for file in "$DIR"/*; do
    # Only process regular files
    if [ -f "$file" ]; then
        # Get filename without extension
        filename_without_ext="$(basename "$file" | sed 's/\.[^.]*$//')"
        sprite_name=$(to_kebab_case "$filename_without_ext")

        # Define the sprite based on the filename
        echo -n "sprite \$${sprite_name}-svg " >> "$OUTPUT"

        # Append the file content skipping the first 2 lines
        tail -n +3 "$file" >> "$OUTPUT"
    fi
    echo "" >> "$OUTPUT"
done
