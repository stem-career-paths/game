extends GutTest

const _JSON_DATA := """
{
	"text": "Sample",
	"options": [
		{
			"name": "Option 1",
			"text": "This is option 1",
			"effects": {
				"science": "1",
				"engagement": "1"
			},
		},
		{
			"name": "Option 2",
			"text": "This is option 2",
			"effects": {
				"technology": "1,"
			},
		}
	]
}
"""

func test_parse():
	var parser := StoryCardParser.new()
	var card := parser.parse(_JSON_DATA)
	assert_not_null(card)
	assert_eq(card.text, "Sample")
	assert_eq(card.options.size(), 2)
	assert_eq(card.options[0].text, "Option 1")
	assert_eq(card.options[0].effects.size(), 2)
	assert_eq(card.options[0].effects[0].attribute_name, "science")
	assert_eq(card.options[0].effects[0].value, 1)
	assert_eq(card.options[1].text, "Option 2")
	assert_eq(card.options[1].effects.size(), 1)
	
