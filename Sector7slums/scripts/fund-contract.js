const Sector7slums = artifacts.require('Sector7slums')
const LinkTokenInterface = artifacts.require('LinkTokenInterface')
const payment = process.env.TRUFFLE_CL_BOX_PAYMENT || '3000000000000000000'

module.exports = async callback => {
  try {
    const s7s = await Sector7slums.deployed()

    const tokenAddress = await s7s.LinkToken()
    console.log("Chainlink Token Address: ", tokenAddress)
    const token = await LinkTokenInterface.at(tokenAddress)
    console.log('Funding contract:', s7s.address)
    const tx = await token.transfer(s7s.address, payment)
    callback(tx.tx)
  } catch (err) {
    callback(err)
  }
}
