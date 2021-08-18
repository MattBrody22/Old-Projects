const Sector7slums = artifacts.require('Sector7slums')
const fs = require('fs')

const metadataTemple = {
    "name": "",
    "description": "",
    "image": "",
    "attributes": [
        {
            "trait_type": "Strength",
            "value": 0
        },
        {
            "trait_type": "Magic",
            "value": 0
        },
        {
            "trait_type": "Vitality",
            "value": 0
        },
        {
            "trait_type": "Spirit",
            "value": 0
        },
        {
            "trait_type": "Luck",
            "value": 0
        },
        {
            "trait_type": "Speed",
            "value": 0
        },
        {
            "trait_type": "Level",
            "value": 0
        }
    ]
}
module.exports = async callback => {
    const s7s = await Sector7slums.deployed()
    length = await s7s.getNumberOfAeriths()
    index = 0
    while (index < length) {
        console.log('Let\'s get the overview of your aerith ' + index + ' of ' + length)
        let aerithMeta = metadataTemple
        let aerithOverview = await s7s.aeriths(index)
        index++
        aerithMeta['name'] = aerithOverview['name']
        if (fs.existsSync('metadata/' + aerithMeta['name'].toLowerCase().replace(/\s/g, '-') + '.json')) {
            console.log('test')
            continue
        }
        console.log(aerithMeta['name'])
        aerithMeta['attributes'][0]['value'] = aerithOverview['Strength']['words'][0]
        aerithMeta['attributes'][1]['value'] = aerithOverview['Magic']['words'][0]
        aerithMeta['attributes'][2]['value'] = aerithOverview['Vitality']['words'][0]
        aerithMeta['attributes'][3]['value'] = aerithOverview['Spirit']['words'][0]
        aerithMeta['attributes'][4]['value'] = aerithOverview['Luck']['words'][0]
        aerithMeta['attributes'][5]['value'] = aerithOverview['Speed']['words'][0]
        filename = 'metadata/' + aerithMeta['name'].toLowerCase().replace(/\s/g, '-')
        let data = JSON.stringify(aerithMeta)
        fs.writeFileSync(filename + '.json', data)
    }
    callback(s7s)
}
