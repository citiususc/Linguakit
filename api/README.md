**\*\*This documentation is still a preliminar draft, so it is uncomplete. In the upcoming weeks it will be updated.\*\***

# Installation
(documentation pending)
# Running the service
## Configuration

You can change the default configuration by editing `lib/config.yml`.

- `linguakit_path`: path (absolute or relative) to Linguakit
- `charset`: default charset
- `port`: default ports for each supported languages
- `log`: log level
- `logger`: device showing logs

## Running the service
### With PSGI (Plack)
Each supported language has a launching script on its own. Some examples:

- Galician on port 3000
```sh
$ cd Linguakit/api
$ plackup -p 3000 app-gl.pl
HTTP::Server::PSGI: Accepting connections at http://0:3000/
```
- Portuguese on port 4003
```sh
$ cd Linguakit/api
$ plackup -p 4003 app-pt.pl
HTTP::Server::PSGI: Accepting connections at http://0:4003/
```
### With Dancer
- Galician on port 2000
```sh
$ cd Linguakit/api
$ perl lib/linguakit_api.pm -l gl -p 2000
>> Dancer2 v0.300005 server 632436 listening on http://0.0.0.0:2000
```
- Spanish on the default port

```sh
$ cd Linguakit/api
$ perl lib/linguakit_api.pm -l es
>> Dancer2 v0.300005 server 657546 listening on http://0.0.0.0:3002
```

Options available:
```sh
$ perl lib/linguakit_api.pm -h
linguakit_api: Linguakit RESTful API

usage: linguakit_api [--help|-h] [--port|-p] [--lang|-l]

optional named arguments:
  --help, -h         ? show this help message and exit
  --port, -p PORT    ? This is option port
  --lang, -l LANG    ? Language resources for LANG will be loaded
                         Choices: [en, es, pt, gl, histgz], case insensitive
```
## Tests
```sh
$ cd Linguakit
$ prove -rv api
api/t/00_get.t ........ 
1..2
ok 1 - [GET /ping] Successful request
ok 2 - [GET /ping] Correct content
ok
api/t/en/01_tagger.t .. 
1..5
ok 1 - test_post_tagger_endpoint
ok 2 - test_port_tagger_empty_sentence
ok 3 - test_post_tagger_sentence
ok 4 - test_post_ner_sentence
ok 5 - test_post_nec_sentence
ok
api/t/es/01_tagger.t .. 
1..5
ok 1 - test_post_tagger_endpoint
ok 2 - test_port_tagger_empty_sentence
ok 3 - test_post_tagger_sentence
ok 4 - test_post_ner_sentence
ok 5 - test_post_nec_sentence
ok
api/t/gl/01_tagger.t .. 
1..5
ok 1 - test_post_tagger_endpoint
ok 2 - test_port_tagger_empty_sentence
ok 3 - test_post_tagger_sentence
ok 4 - test_post_ner_sentence
ok 5 - test_post_nec_sentence
ok
api/t/pt/01_tagger.t .. 
1..5
ok 1 - test_post_tagger_endpoint
ok 2 - test_port_tagger_empty_sentence
ok 3 - test_post_tagger_sentence
ok 4 - test_post_ner_sentence
ok 5 - test_post_nec_sentence
ok
All tests successful.
Files=5, Tests=22, 16 wallclock secs ( 0.02 usr  0.01 sys + 13.97 cusr  1.50 csys = 15.50 CPU)
Result: PASS
```
# Reference
## Supported modules
### Named entity coreference solver
(documentation pending)
### Dependency syntactic analysis
(documentation pending)
### Keyword extraction
(documentation pending)
### Keyword in context (concordances)
(documentation pending)
### Lemmatization
(documentation pending)
### Multiword extraction
(documentation pending)
### Language recognition
(documentation pending)
### Relation extraction
(documentation pending)
### Sentence segmentation
(documentation pending)
### Sentiment analysis
(documentation pending)
### Text summarizer
(documentation pending)
### Part-of-speech tagging

**POST /tagger**

* Endpoint URL: https://{HOST}/v2.0/tagger
* Query parameters
    | Name | Type | Importance | Description |
    | :-- | :-- | :-- | :-- |
    | text | string | required | Input text to be processed. |
    | output | string | optional | Detect and classify named-entities. Accepted values: "ner" (named-entity recognition), "nec" (named-entity recognition and classification). |
* Example request
    - cURL
        Named-entity recognition and classification of a sentence:
        ```
        curl -s -X POST http://localhost:3002/v2.0/tagger -d '{"output": "nec", "text": "Santiago vive en A Coruña, pero pasa las vacaciones en Santiago."}'
        ```

        PoS tagging (without named-entity recognition) of the same sentence
        ```
        curl -s -X POST http://localhost:3002/v2.0/tagger -d '{"text": "Santiago vive en A Coruña, pero pasa las vacaciones en Santiago."}'
        ```
* Example response
    - JSON
        Named-entity recognition and classification of a sentence:
        ```json
        [
            "Santiago santiago NP00SP0",
            "vive vivir VMIP3S0",
            "en en SPS00",
            "A_Coruña a_coruña NP00G00",
            ", , Fc",
            "pero pero CC",
            "pasa pasar VMIP3S0",
            "las el DA0FP0",
            "vacaciones vacación NCFP000",
            "en en SPS00",
            "Santiago santiago NP00G00",
            ". . Fp"
        ]
        ```
        
        PoS tagging (without named-entity recognition) of the same sentence
        ```json
        [
            "Santiago santiago NP00000",
            "vive vivir VMIP3S0",
            "en en SPS00",
            "A a SPS00",
            "Coruña coruña NP00000",
            ", , Fc",
            "pero pero CC",
            "pasa pasar VMIP3S0",
            "las el DA0FP0",
            "vacaciones vacación NCFP000",
            "en en SPS00",
            "Santiago santiago NP00000",
            ". . Fp"
        ]
        ```
* Response type: list

### Tokenizer

## Unsupported modules

The following modules are not supported, since the Linguakit code is a call to another RESTful API. You can made the call directly in case you are interested.

### Language checker (Avalingua)

**POST /smart_corrector**

(documentation pending)

### Entity linking and semantic annotation

**POST /semantic_annotator**

(documentation pending)

### Verb conjugator

**POST /conjugator**

* Endpoint URL: https://tec.citius.usc.es/linguakit/conjugator
* Query parameters
    | Name | Type | Importance | Description |
    | :-- | :-- | :-- | :-- |
    | text | string | required | Input text to be processed. It must be a verb in the specified language. |
    | lang_input | string | required | ISO-639-1 language code. Accepted values: "es", "gl", "pt" (default). |
    | format | string | optional | Output format. Accepted values: "text" (default), "json". |
    | variety | string | optional | Portuguese variety. Accepted values: "pt_pt" (European Portuguese, default), "pt_br" (Brazilian Portuguese), "pt_pt_sao" (European Portuguese before the spelling agreement), "pt_br_sao" (Brazilian Portuguese before the spelling agreement).
* Example request
    - cURL
        Conjugation of the spanish verb *soñar* in JSON format:
        ```
        curl -s -X POST "https://tec.citius.usc.es/linguakit/conjugator" -d 'text=soñar&lang_input=es&format=json'
        ```

        Conjugation of the portuguese verb *brincar*, in the Brazilian Portuguese variety and text format.
        ```
        curl -s -X POST "https://tec.citius.usc.es/linguakit/conjugator" -d 'text=bailar&lang_input=pt&variety=pt_br'
        ```
* Example response
    - JSON
        ```json
        {
        "conjugations": [
            {
                "conjugation": [
                    {
                        "code_tense":"PI",
                        "verbal_form": [
                            {"person":"Eu", "form":"brinco"},
                            {"person":"Tu", "form":"brincas"},
        ...
        ],
        "lang":"pt",
        "verb":"brincar",
        "known":1
        }
        ```
    - Text
        ```
        PI:brinco:brincas:brinca:brincamos:brincais:brincam
        EI:brinquei:brincaste:brincou:brincamos:brincastes:brincaram
        II:brincava:brincavas:brincava:brincávamos:brincáveis:brincavam
        MI:brincara:brincaras:brincara:brincáramos:brincáreis:brincaram
        FI:brincarei:brincarás:brincará:brincaremos:brincareis:brincarão
        TI:brincaria:brincarias:brincaria:brincaríamos:brincaríeis:brincariam
        PS:brinque:brinques:brinque:brinquemos:brinqueis:brinquem
        IS:brincasse:brincasses:brincasse:brincássemos:brincásseis:brincassem
        FS:brincar:brincares:brincar:brincarmos:brincardes:brincarem
        IP:brincar:brincares:brincar:brincarmos:brincardes:brincarem
        IA:brinca:brinque:brinquemos:brincai:brinquem
        IN:brinques:brinque:brinquemos:brinqueis:brinquem
        FN:brincar:brincando:brincado
        ```
* Response fields
    | Name | Type | Description |
    | :-- | :-- | :-- |
    | lang | string | Language specified in the request.  |
    | known | boolean | Whether the requested verb is in our verb database or not. |
    | verb | string | Requested verb. |
    | conjugations | array | List of conjugations of the requested verb. |
