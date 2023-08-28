const { expect } = require('chai');
const { ethers } = require('hardhat');

describe('Enums', () => {

  describe('Example 1', () => {

    it('demonstrates read / write / update behavior of enums', async () => {
      const Contract = await ethers.getContractFactory('Enums1');
      let contract = await Contract.deploy();

      // defaults to 0
      expect(await contract.get()).to.equal(0);

      // manually set to "in progress"
      await contract.set(1);
      expect(await contract.get()).to.equal(1);

      // cancel
      await contract.complete();
      expect(await contract.get()).to.equal(2);

      // reset status to "Todo"
      await contract.reset();
      expect(await contract.get()).to.equal(0);
    });
  });

});
