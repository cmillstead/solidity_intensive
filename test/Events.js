const { expect } = require('chai');
const { ethers } = require('hardhat');

describe('Events', () => {

  describe('Example 1', () => {
    let user1, user2;

    beforeEach(async () => {
      let accounts = await ethers.getSigners();
      user1 = accounts[0];
      user2 = accounts[1];
    });

    it('demonstrates basic event subscription and history', async () => {
      const Contract = await ethers.getContractFactory('Events1');
      let contract = await Contract.deploy();

      // call it once, check the event log in real time
      let transaction = await contract.updateMessage('Hey!');
      await transaction.wait();
      await expect(transaction).to.emit(contract, 'MessageUpdated')
        .withArgs(user1.address, 'Hey!');

      // call it a few more times to get event history
      transaction = await contract.updateMessage('Ho!');
      await transaction.wait();

      transaction = await contract.updateMessage('Ha!');
      await transaction.wait();

      // get all past events
      let eventStream = await contract.queryFilter('MessageUpdated');
      expect(eventStream.length).to.equal(3);

      // check first event in the stream
      let firstEvent = eventStream[0];
      expect(firstEvent.args[1]).to.equal('Hey!');

      let secondEvent = eventStream[1];
      expect(secondEvent.args[1]).to.equal('Ho!');

      let thirdEvent = eventStream[2];
      expect(thirdEvent.args[1]).to.equal('Ha!');

      // trigger event from user 2
      transaction = await contract.connect(user2).updateMessage('Huh!');
      await transaction.wait();

      // filter only events created by user2
      let user2Filter = contract.filters.MessageUpdated(user2.address, null);
      eventStream = await contract.queryFilter(user2Filter);
      expect(eventStream.length).to.equal(1);

      // make sure it's user 2's message
      firstEvent = eventStream[0];
      expect(firstEvent.args[1]).to.equal('Huh!');
      expect(firstEvent.args[0]).to.equal('0x70997970C51812dc3A010C7d01b50e0d17dc79C8');
    });
  });

});
