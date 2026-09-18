# gtm-template-local-storage

The Local Storage Variable is used to read values from the browser's local storage in Google Tag Manager.

This template extends the GTM container with the familiar functionality of the native first-party cookie variable, adapted for web storage.

## Main Features
- Data Access: Reads key-value pairs from the current domain's local storage.
- JSON Parsing: Optional automatic conversion of JSON strings into JavaScript objects.

## Examples of Use
- A/B Testing & Personalization: Retrieving variant IDs or user segments from local storage to control tag firing.
- Consent & Privacy: Reading storage settings or consent strings to determine trigger conditions.
- First-Party User IDs: Passing anonymous client or user IDs to analytics and marketing tags.
- E-Commerce: Accessing cached shopping cart information (e.g., number of items or cart value) for trigger conditions.

## Setup in GTM
1. Create a new variable of the Local Storage type.
2. Specify the exact entry name under Key Name (e.g., user_segment).
3. (Optional) Enable Automatically parse JSON value if the stored value is formatted as a JSON string.
4. Include the variable in the desired triggers or tags.