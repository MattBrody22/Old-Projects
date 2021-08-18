const Sector7slums = artifacts.require('Sector7slums')

module.exports = async callback => {
  const s7s = await Sector7slums.deployed()
  console.log('Creating requests on contract:', s7s.address)
  const tx = await s7s.requestNewRandomAerith('Aerith #1')
  const tx2 = await s7s.requestNewRandomAerith('Aerith #2')
  const tx3 = await s7s.requestNewRandomAerith('Aerith #3')
  const tx4 = await s7s.requestNewRandomAerith('Aerith #4')
  const tx5 = await s7s.requestNewRandomAerith('Aerith #5')
  const tx6 = await s7s.requestNewRandomAerith('Aerith #6')
  const tx7 = await s7s.requestNewRandomAerith('Aerith #7')
  const tx8 = await s7s.requestNewRandomAerith('Aerith #8')
  const tx9 = await s7s.requestNewRandomAerith('Aerith #9')
  const tx10 = await s7s.requestNewRandomAerith('Aerith #10')
  callback(tx.tx)
}
