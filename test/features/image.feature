Feature: Create Image Files
  As a drupal user
  I want to be able to create Images
  So that I can embed to content

Background:
  Given "division_office" terms:
    | name              |
    | behat             |
    | office of justice |

@api @javascript
Scenario: Admin Can Create And Publish Image Content File
  Given I am logged in as a user with the "Administrator" role
  When I visit "/node/add/image"
    And I fill in "Title" with "BEHAT Image File"
    And I attach the file "behat-black_rabbit.jpg" to "Image Upload"
    And I wait for ajax to finish
    And I fill in "Alternative text" with "silly rabbit"
    And I select "office of justice" from "Primary Division/Office"
    And I click on the element with css selector ".dropbutton-arrow"
    And I should see the "Save and Publish" button
    And I should see the "Save and Create New Draft" button
    And I should see the "Save and Request Review" button
    And I click on the element with css selector ".dropbutton-arrow"
    And I publish it
  Then I should see the "img" element with the "alt" attribute set to "silly rabbit" in the "contentarea" region
    And I should see the "img" element with the "src" attribute set to "/behat-black_rabbit" in the "contentarea" region
  When I am on "/image/behat-image-file/edit"
  Then I should see the text "Published" in the "edit_meta" region

@api @javascript
Scenario: Edit Image File As Admin
  Given "image" content:
    | title            | field_primary_division_office | moderation_state |
    | BEHAT Image File | behat                         | published        |
    And I am logged in as a user with the "Administrator" role
  When I visit "/image/behat-image-file/edit"
    And I fill in "Title" with "Updated Image File Test"
    And I attach the file "behat-gold-pig.png" to "Image Upload"
    And I wait for ajax to finish
    And I fill in "Alternative text" with "silly pig"
    And I press "Save and Create New Draft"
  Then I should see the "img" element with the "alt" attribute set to "silly pig" in the "contentarea" region
    And I should see the "img" element with the "src" attribute set to "/behat-gold-pig" in the "contentarea" region

@api
Scenario: Admin Can Delete Image Content File
  Given I am logged in as a user with the "Administrator" role
    And "image" content:
      | title            | field_primary_division_office | moderation_state |
      | BEHAT Image File | behat                         | draft            |
  When I visit "/admin/content"
    And I click "Edit" in the "BEHAT Image File" row
    And I click "edit-delete"
    And I press the "Delete" button
  Then I should not see the link "BEHAT Image File"

@api @javascript
Scenario Outline: Authorized Users Can Delete Image Media
  Given I create "media" of type "image_media":
    | name              | field_media_image | field_media_caption | status | mid    |
    | Behat Puppy Image | behat-puppy.jpg   | This is a puppy     | 1      | 902100 |
  When I visit "/media/902100"
  Then I should see the "img" element with the "src" attribute set to "/files/images/behat-puppy.jpg" in the "contentarea" region
  When I visit "/files/images/behat-puppy.jpg"
  Then I should see the "img" element with the "src" attribute set to "http://sec.lndo.site/files/images/behat-puppy.jpg" in the "image" region
  When I am logged in as a user with the "<role>" role
    And I am on "/media/902100/delete"
    And I press "Delete"
  Then I see the text "The media item Behat Puppy Image has been deleted."
  When I am on "/admin/content/files"
  Then I should not see the link "behat-puppy.jpg"
  # External users should not be able to view the deleted file
  When I run drush "cr"
    And I am not logged in
    And I visit "/media/902100"
    And I reload the page
  Then I should see the heading "Oops! Page Not Found."
  When I visit "/files/images/behat-puppy.jpg"
  Then I should see the heading "Not Found"

    Examples:
    | role                  |
    | content_creator       |
    | content_approver      |
    | division_office_admin |
    | sitebuilder           |
    | administrator         |

@api @javascript
Scenario: Deleted Image Media Should Not Be Accessible From Embed Referenced
  Given I create "media" of type "image_media":
    | name              | field_media_image | field_media_caption | status | mid    |
    | Behat Puppy Image | behat-puppy.jpg   | This is a puppy     | 1      | 902100 |
  When I am logged in as a user with the "content_approver" role
    And I am on "/node/add/secarticle"
    And I select "Other" from "Article Type"
    And I fill in "Title" with "BEHAT Testing Image Embed Deletion"
    And I fill in "Display Title" with "BEHAT DT Testing Image Embed"
    And I scroll "#edit-body-wrapper" into view
    And I press "Media Embed" in the "Body" WYSIWYG Toolbar
    And I wait for ajax to finish
    And I select the first autocomplete option for "Behat Puppy Image" on the "Name" field on a modal
    And I click "Next" on the modal "Select media item to embed"
    And I wait for ajax to finish
    And I select "Thumbnail" from "Display as"
    And I wait for ajax to finish
    And I fill in "Alternate text" with "picture of a puppy"
    And I fill in "Caption" with "Embed level caption"
    And I click "Embed" on the modal "Embed media item"
    And I wait for ajax to finish
    And I select "office of justice" from "Primary Division/Office"
    And I publish it
  Then I should see the heading "BEHAT DT Testing Image Embed"
    And I should see the "img" element with the "alt" attribute set to "picture of a puppy" in the "contentarea" region
  When I visit "/media/902100/delete"
    And I press "Delete"
  Then I see the text "The media item Behat Puppy Image has been deleted."
  # External users should not be able to view the deleted file
  When I am not logged in
    And I visit "/behat-testing-image-embed-deletion"
  Then I should see the "img" element with the "alt" attribute set to "Missing media item" in the "contentarea" region
  When I visit "/files/images/behat-puppy.jpg"
  Then I should see the heading "Not Found"

@api @javascript
Scenario: Deleted Image Media Should Not Be Accessible From Linkit Referenced
  Given I create "media" of type "image_media":
    | name              | field_media_image | field_media_caption | status | mid    |
    | Behat Puppy Image | behat-puppy.jpg   | This is a puppy     | 1      | 902100 |
  When I am logged in as a user with the "content_approver" role
    And I am on "/node/add/secarticle"
    And I select "Other" from "Article Type"
    And I fill in "Title" with "BEHAT Testing Image Linkit Deletion"
    And I fill in "Display Title" with "BEHAT DT Testing Image Linkit"
    And I scroll "#edit-body-wrapper" into view
    And I press "Link (Ctrl+K)" in the "Body" WYSIWYG Toolbar
    And I wait for ajax to finish
    And I fill in "/media/902100" for "URL" in the "modal" region
    And I click "Save" on the modal "Add Link"
    And I wait for ajax to finish
    And I select "office of justice" from "Primary Division/Office"
    And I publish it
  Then I should see the heading "BEHAT DT Testing Image Linkit"
  When I click "/media/902100"
  Then I should see the "img" element with the "src" attribute set to "/files/images/behat-puppy.jpg" in the "contentarea" region
  When I visit "/media/902100/delete"
    And I press "Delete"
  Then I see the text "The media item Behat Puppy Image has been deleted."
  # External users should not be able to view the deleted file
  When I am not logged in
    And I visit "/behat-testing-image-linkit-deletion"
    And I click "/media/902100"
  Then I should see the heading "Oops! Page Not Found."
  When I visit "/files/images/behat-puppy.jpg"
  Then I should see the heading "Not Found"

@api @javascript
Scenario: Replaced Image Media Should Be Updated Immediately
  Given I create "media" of type "image_media":
    | name                          | field_media_image | field_media_caption    | status | mid    |
    | Behat Puppy, Not Rabbit Image | behat-rabbit.jpg  | This should be a puppy | 1      | 902100 |
  When I am on "/files/images/behat-rabbit.jpg"
  Then I should see the "img" element with the "src" attribute set to "/files/images/behat-rabbit.jpg" in the "image" region
  When I am logged in as a user with the "content_approver" role
    And I am on "/media/902100/edit"
    And I attach the file "behat-puppy.jpg" to "File"
    And I wait for ajax to finish
    And I check the box "edit-keep-original-filename"
    And I fill in "Alternative text" with "image alt text"
    And I press "Save"
    And I am not logged in
    And I am on "/media/902100"
  Then I should see the "img" element with the "src" attribute set to "/files/images/behat-rabbit.jpg" in the "contentarea" region
  When I am on "/files/images/behat-rabbit.jpg"
  Then I should see the "img" element with the "src" attribute set to "/files/images/behat-rabbit.jpg" in the "image" region
    And I should see the "img" element with the "width" attribute set to "895" in the "image" region

@api @javascript
Scenario: Replaced Image Media Should Be Updated From LinkIt Referenced
  Given I create "media" of type "image_media":
    | name                      | field_media_image | field_media_caption | status | mid    |
    | Behat Dogs, Not Dog Image | behat-dog.jpeg    | This should be dogs | 1      | 902100 |
  When I am logged in as a user with the "content_approver" role
    And I am on "/node/add/secarticle"
    And I select "Other" from "Article Type"
    And I fill in "Title" with "BEHAT Media Replace Linkit Test"
    And I fill in "Display Title" with "media replace linkit test"
    And I scroll "#edit-body-wrapper" into view
    And I wait 2 seconds
    And I press "LinkIt (Ctrl+K)" in the "Body" WYSIWYG Toolbar
    And I wait for ajax to finish
    And I fill in "/media/902100" for "URL" in the "modal" region
    And I click "Save" on the modal "Add Link"
    And I wait 2 seconds
    And I select "office of justice" from "Primary Division/Office"
    And I publish it
  Then I should see the heading "media replace linkit test"
  When I click "/media/902100"
    And I wait 1 seconds
  Then I should see the "img" element with the "src" attribute set to "/files/images/behat-dog.jpeg" in the "contentarea" region
    And I should see the "img" element with the "width" attribute set to "179" in the "contentarea" region
    And I should see the "img" element with the "height" attribute set to "135" in the "contentarea" region
  When I am on "/media/902100/edit"
    And I attach the file "behat-dogs.jpeg" to "File"
    And I wait for ajax to finish
    And I check the box "edit-keep-original-filename"
    And I fill in "Alternative text" with "image alt text"
    And I select "office of justice" from "Primary Division/Office"
    And I press "Save"
  # External users should not be able to view the previous file
    And I am not logged in
    And I visit "/behat-media-replace-linkit-test"
    And I click "/media/902100"
  Then I should see the heading "Behat Dogs, Not Dog Image"
    And I should see the "img" element with the "src" attribute set to "/files/images/behat-dog.jpeg" in the "contentarea" region
    And I should see the "img" element with the "width" attribute set to "1000" in the "contentarea" region
    And I should see the "img" element with the "height" attribute set to "714" in the "contentarea" region
  When I am on "/files/images/behat-dog.jpeg"
  Then I should see the "img" element with the "src" attribute set to "http://sec.lndo.site/files/images/behat-dog.jpeg" in the "image" region
    And the "title" element should contain "behat-dog.jpeg (1000×714)"

@api @javascript
Scenario: Replaced Image Media Should Be Updated From Embed Referenced
  Given I create "media" of type "image_media":
    | name                         | field_media_image | field_media_caption    | status | mid    |
    | Behat Kittens, Not Cat Image | behat-cat.png     | This should be kittens | 1      | 902100 |
  When I am logged in as a user with the "content_approver" role
    And I am on "/node/add/secarticle"
    And I select "Other" from "Article Type"
    And I fill in "Title" with "BEHAT Media Replace Embed Test"
    And I fill in "Display Title" with "media replace embed test"
    And I scroll "#edit-body-wrapper" into view
    And I wait 1 seconds
    And I press "Media Embed" in the "Body" WYSIWYG Toolbar
    And I wait for ajax to finish
    And I select the first autocomplete option for "Behat Kittens, Not Cat Image" on the "Name" field on a modal
    And I click "Next" on the modal "Select media item to embed"
    And I wait for ajax to finish
    And I select "Thumbnail" from "Display as"
    And I wait for ajax to finish
    And I fill in "Alternate text" with "picture of kittens"
    And I fill in "Caption" with "Embed level caption"
    And I click "Embed" on the modal "Embed media item"
    And I wait for ajax to finish
    And I select "office of justice" from "Primary Division/Office"
    And I publish it
  Then I should see the heading "media replace embed test"
    And I should see the "img" element with the "src" attribute set to "/files/images/behat-cat.png" in the "contentarea" region
    And I should see the "img" element with the "width" attribute set to "240" in the "contentarea" region
    And I should see the "img" element with the "height" attribute set to "277" in the "contentarea" region
  When I am on "/media/902100/edit"
    And I attach the file "behat-kittens.png" to "File"
    And I wait for ajax to finish
    And I check the box "edit-keep-original-filename"
    And I fill in "Alternative text" with "image alt text"
    And I select "office of justice" from "Primary Division/Office"
    And I press "Save"
  # External users should not be able to view the deleted file
    And I am not logged in
    And I visit "/behat-media-replace-embed-test"
  Then I should see the "img" element with the "src" attribute set to "/files/images/behat-cat.png" in the "contentarea" region
    And I should see the "img" element with the "width" attribute set to "240" in the "contentarea" region
    And I should see the "img" element with the "height" attribute set to "277" in the "contentarea" region
  When I am on "/files/images/behat-cat.png"
  Then I should see the "img" element with the "src" attribute set to "http://sec.lndo.site/files/images/behat-cat.png" in the "image" region
    And the "title" element should contain "behat-cat.png (960×540)"

@api @javascript
Scenario: Image Media Thumbnail
  Given I am logged in as a user with the "content_approver" role
  When I visit "/media/add/image_media"
    And I fill in "Title" with "My favorite SEC.gov Image"
    And I attach the file "behat-test_shiba_snow.jpg" to "Image Upload"
    And I wait 3 seconds
    And I should see the link "behat-test_shiba_snow.jpg"
    And the hyperlink "behat-test_shiba_snow.jpg" should match the Drupal url "/system/files/filefield_paths/behat-test_shiba_snow.jpg"
    And I should see the "img" element with the "src" attribute set to "/system/files/styles/thumbnail/private/filefield_paths/behat-test_shiba_snow.jpg" in the "media_image_thumbnail" region
    And I fill in "Caption" with "Shiba playing in snow"
    And I fill in "Alternative text" with "snow shiba"
    And I check the box "edit-status-value"
    And I press "Save"
  Then I should see the link "My favorite SEC.gov Image"
  When I click "My favorite SEC.gov Image"
  Then I should see the heading "My favorite SEC.gov Image"
    And I should see the "img" element with the "src" attribute set to "/files/images/behat-test_shiba_snow.jpg" in the "contentarea" region
