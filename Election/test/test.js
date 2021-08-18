const Election = artifacts.require('./Election.sol');

contract('Election', function(accounts) {
	it('checks number of candidates', function() {
		return Election.deployed().then(function(instance) {
			return instance.candidatesCount();
		}).then(function(count) {
			assert.equal(count, 4);
		});
	});

	it('checking values', function() {
		return Election.deployed().then(function(instance) {
			electionInstance = instance;
			return electionInstance.candidates(1);
		}).then(function(candidate) {
			assert.equal(candidate[0], 1, 'correct id');
			assert.equal(candidate[1], 'Marlee', 'correct name');
			assert.equal(candidate[2], 0, 'correct amount of votes');
			return electionInstance.candidates(2);
		}).then(function(candidate) {
			assert.equal(candidate[0], 2, 'correct id');
			assert.equal(candidate[1], 'Dami', 'correct name');
			assert.equal(candidate[2], 0, 'correct amount of votes');
			return electionInstance.candidates(2);
		});
	});

	it('checking votes', function() {
		return Election.deployed().then(function(instance) {
			electionInstance = instance;
			candidateId = 1;
			return electionInstance.vote(candidateId, {from: accounts[0]});
		}).then(function(receipt) {
			return electionInstance.voters(accounts[0]);
		}).then(function(voted) {
			asser(voted, 'voter has been marked');
			return electionInstance.candidates(candidatedId);
		}).then(function(candidate) {
			let voteCount = candidate[2];
			assert.equal(voteCount, 1, 'increments the vote count');
		});
	});

	it('checking candidates', function() {
		return Election.deployed().then(function(instance) {
			electionInstance = instance;
			return electionInstance.vote(22, {from:accounts[1]});
		}).then(assert.fail).catch(function(error) {
			assert(error.message.indexOf('revert') >= 0, 'error');
			return electionInstance.candidates(1);
		}).then(function(candidate1) {
			let voteCount = candidate1[2];
			assert.equal(voteCount, 1, 'did not recieve votes');
			return electionInstance.candidates(2);
		}).then(function(candidate2) {
			let voteCount = candidate2[2];
			assert.equal(voteCount, 0, 'did not recieve any votes');
		});
	});

	it('double voting', function() {
		return Election.deployed().then(function(instance) {
			electionInstance = instance;
			candidateId = 2;
			electionInstance.vote(cnadidateId, {from:accounts[1]});
			return electionInstance.candidates(candidateId);
		}).then(function(candidate) {
			let voteCount = candidate[2];
			assert.equal(voteCount, 1, 'first vote');
			return electionInstance.vote(candidateId, {from:accounts[1]});
		}).then(assert.fail).catch(function(error) {
			assert(error.message.indexOf('revert') >= 0, 'error');
			return electionInstance.candidates(1);
		}).then(function(candidate1) {
			let voteCount = candidate1[2];
			assert.equal(voteCount, 1, 'did not recieve vote');
			return electionInstance.candidates(2);
		}).then(function(candidate2) {
			let voteCount = candidate2[2];
			assert.equal(voteCount, 1, 'did not recieve any votes');
		});
	});
});