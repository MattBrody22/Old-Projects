const Sector7slums = artifacts.require('Sector7slums')

module.exports = async callback => {
    const s7s = await Sector7slums.deployed()
    console.log('Let\'s get the overview of your aerith')
    const overview = await s7s.aeriths(0)
    console.log(overview)
    callback(overview.tx)
}
