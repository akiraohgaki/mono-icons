#!/bin/bash

# Batch convert from Inkscape SVG to PNG

# Requirements
#
# Inkscape and ImageMagick

# Usage
#
# sh batch-convert.sh

# Convert options
source_icons_dir='./mono-icons-inkscape'
original_color_icons_dir='./mono-icons-black'
negative_color_icons_dir='./mono-icons-white'
small_geometry=16
medium_geometry=22
large_geometry=48

# Change current working directory
cd `dirname $0`

# Convert to PNG
for geometry in $small_geometry $medium_geometry $large_geometry
do
    for sub_dir in $source_icons_dir/*
    do
        sub_dir=`basename $sub_dir`
        export_dir=$original_color_icons_dir/$geometry/$sub_dir
        mkdir -p $export_dir
        for import_file in $source_icons_dir/$sub_dir/*.svg
        do
            export_file=$export_dir/`basename $import_file .svg`'.png'
            inkscape -z -f $import_file -e $export_file -w $geometry -h $geometry
        done
    done
done

# Convert to negative color
cp -r $original_color_icons_dir $negative_color_icons_dir
mogrify -negate $negative_color_icons_dir/*/*/*.png
