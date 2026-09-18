___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Local Storage",
  "categories": ["UTILITY"],
  "description": {
    "text": "The value is set to the value of the local storage item with the matching name.",
    "translations": [
      {
        "locale": "de",
        "text": "Der Wert wird auf den Wert des Local-Storage-Eintrags mit dem übereinstimmenden Namen festgelegt."
      }
    ]
  },
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "keyName",
    "displayName": {
      "text": "Key Name",
      "translations": [
        {
          "locale": "de",
          "text": "Schlüsselname"
        }
      ]
    },
    "simpleValueType": true
  },
  {
    "type": "CHECKBOX",
    "name": "parseJson",
    "checkboxText": {
      "text": "Automatically parse JSON value",
      "translations": [
        {
          "locale": "de",
          "text": "JSON-Wert automatisch parsen"
        }
      ]
    },
    "simpleValueType": true
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const localStorage = require('localStorage');
const JSON = require('JSON');

const key = data.keyName;
if (!key) {
  return undefined;
}

let value = localStorage.getItem(key);

if (value === null) {
  value = undefined;
}

if (value !== undefined && data.parseJson) {
  const trimmedValue = value.trim();
  const looksLikeJson = trimmedValue.indexOf('{') === 0 || trimmedValue.indexOf('[') === 0;
  if (looksLikeJson) {
    const parsedValue = JSON.parse(value);
    if (parsedValue !== undefined) {
      value = parsedValue;
    }
  }
}

return value;


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "access_local_storage",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: Returns the stored value
  code: |
    storage['my-key'] = 'my-value';

    const variableResult = runCode({
      keyName: 'my-key',
      parseJson: false
    });

    assertThat(variableResult).isEqualTo('my-value');
- name: Returns undefined if the key does not exist
  code: |
    const variableResult = runCode({
      keyName: 'unknown-key',
      parseJson: false
    });

    assertThat(variableResult).isUndefined();
- name: Returns undefined if no key name was provided
  code: |-
    const variableResult = runCode({
      keyName: '',
      parseJson: false
    });
- name: Calls getItem with the configured key name
  code: |
    storage['expected-key'] = 'value';

    runCode({
      keyName: 'expected-key',
      parseJson: false
    });

    assertThat(getItemCalls).containsExactly('expected-key');
- name: Parses the value as JSON if the checkbox is checked
  code: |
    storage['my-key'] = '{"foo":"bar","count":2}';

    const variableResult = runCode({
      keyName: 'my-key',
      parseJson: true
    });

    assertThat(variableResult).isEqualTo({foo: 'bar', count: 2});
- name: Do not parse the value if the checkbox is unchecked
  code: |
    storage['my-key'] = '{"foo":"bar"}';

    const variableResult = runCode({
      keyName: 'my-key',
      parseJson: false
    });

    assertThat(variableResult).isEqualTo('{"foo":"bar"}');
- name: Returns the raw value if the value is not valid JSON
  code: |
    storage['my-key'] = 'not-json';

    const variableResult = runCode({
      keyName: 'my-key',
      parseJson: true
    });

    assertThat(variableResult).isEqualTo('not-json');
setup: |-
  let storage;
  let getItemCalls;

  storage = {};
  getItemCalls = [];

  mockObject('localStorage', {
    getItem: function(key) {
      getItemCalls.push(key);
      return storage[key] === undefined ? null : storage[key];
    }
  });


___NOTES___

Created on 18.9.2026, 08:53:25


