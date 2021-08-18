const MyDocs = artifacts.require('./MyDocs.sol')

require('chai')
	.use(require('chai-as-promised'))
	.should()

contract('MyDocs', ([deployer, uploader]) => {
	let mydocs

	before(async () => {
		mydocs = await MyDocs.deployed()
	})

	describe('deployed', async () => {
		it('successful', async () => {
			const address = await mydocs.address
			assert.notequal(address, 0x0)
			assert.notequal(address, '')
			assert.notequal(address, null)
			assert.notequal(address, undefined)
		})

		it('checking for name', async () => {
			const name = await mydocs.name()
			assert.equal(name, 'MyDocs')
		})
	})

	describe('docs', async () => {
		let result, amount
		const docsHash = ''
		const docsSize = '1'
		const docsType = 'docsType of doc'
		const docsName = 'docsName of doc'
		const Description = 'Description of doc'

		before(async () => {
			result = await mydocs.docsUpload(docsHash, docsSize, docsType, docsName, Description, {from:uploader})
			amount = await mydocs.amount()
		})

		it('docs uploaded', async () => {
			assert.equal(amount, 1)
			const event = result.logs[0].args 
			assert.equal(event.id.toNumber(), amount.toNumber(), 'correct id')
			assert.equal(event.docsHash, docsHash, 'correct docsHash')
			assert.equal(event.docsSize, docsSize, 'correct docsSize')
			assert.equal(event.docsType, docsType, 'correct docsType')
			assert.equal(event.docsName, docsName, 'correct docsName')
			assert.equal(event.Description, desription, 'correct Description')
			assert.equal(event.uploader, uploader, 'correct uploader')
			await mydocs.docsUpload('', docsSize, docsType, docsName, Description, {from:uploader}).should.be.rejected;
			await mydocd.docsUpload(docsHash, '', docsType, docsName, Description, {from:uploader}).should.be.rejected;
			await mydocs.docsUpload(docsHash, docsSize, '', docsName, Description, {from:uploader}).should.be.rejected;
			await mydocs.docsUpload(docsHash, docsSize, docsType, '', Description, {from:uploader}).should.be.rejected;
			await mydocs.docsUpload(docsHash, docsSize, docsType, docsName, '', {from:uploader}).should.be.rejected;
		})

		it('Docs list', async () => {
			const docs = await mydocs.docs(amount)
			assert.equal(docs.id.toNumber(), amount.toNumber(), 'correct id')
			assert.equal(docs.docsHash, docsHash, 'correct docsHash')
			assert.equal(docs.docsSize, docsSize, 'correct docsSize')
			assert.equal(docs.docsName, docsName, 'correct docsName')
			assert.equal(docs.Description, Description, 'correct Description')
			assert.equal(docs.uploader, uploader, 'correct uploader')
		})
	})
})