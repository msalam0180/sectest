##OASB Capital Raising Map Block (OSSS-16951)
The Capital Raising Map was originally developed by the SEC Data Team in coordination with OASB. It was then updated to work within a Drupal block in the sec_custom_blocks module.

###Adding Map to a Page
- Upload required data files as Media (see below for more details)
- Add Capital Raising Map Block to a page

###Updating Map Code
If code updates are needed in the future, the custom code is in the following files:

- js/oasb_raising_capital_map/main.js
- templates/block--raising-capital-map.html.twig
- css/oasb_raising_capital_map/style.css

For library updates: see sec_custom_blocks.libraries.yml

###Data Source
The Map is driven by data that is stored as media files. This allows content creators to update the data as it changes. 

The following media files are required for the map to work as expected.

- registered.json
- regD.json
- regCF.json
- regA.json
- county.json

In case of an issue, a backup of these required data files is stored in js/oasb_raising_capital_map/backup-required-data-files