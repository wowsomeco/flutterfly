# flutterfly

A collection of Lightweight Material UI components.

![](flutterfly_demo.gif)

## Contents

- UI Components
    - Badge
    - URL Image
    - Card
    - Button

- Form Components
    - Checkbox
    - Datepicker
    - Dropdown
    - Numeric
    - Timeline

## Documentation

Coming Soon

## Purpose

This package will not replace the current existing Flutter Material Widgets. They're both meant to coexist.

It consists of a set of UI components that will reduce (y)our development costs drastically. Some of them are nonexistent e.g. Badge, Datepicker Form Field, etc. 
Some of them already exist but we found that it's not too pretty and doesn't really satisfy our needs e.g. FlyDropdown<T, U> where it's meant to be an alternative of the current existing Dropdown Form Field with more use case where sometimes the Dropdown options can be of a List of Some class-based model (might have been a class that has both int id and String name) that when one of them is selected, it only needs to store the id, not the class itself.
Some of them are the wrappers of the current Material Widgets e.g. FlyCard where it wraps up the existing Card widget that can be aligned both vertically or horizontally with less effort as compared to the built-in one.

Additionally, we would like to showcase to our internal team about UI/UX guidelines as well as the best practices when it comes to making apps for our clients too that are reflected in the example pages.

We'll be constantly updating this package should there be demands internally OR if any of you have some suggestions of Widget that doesn't exist that is generic enough to cater for different needs.