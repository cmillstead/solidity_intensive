const { expect } = require('chai');
const { ethers } = require('hardhat');

describe('Arrays', () => {

  describe('Example 1', () => {

    it('demonstrates array initialization & types', async () => {
      const Contract = await ethers.getContractFactory('Arrays1');
      let contract = await Contract.deploy();
      expect(await contract.array1(0)).to.equal(1);
      expect(await contract.array1(1)).to.equal(2);
      expect(await contract.array1(2)).to.equal(3);

      expect(await contract.array3(0)).to.equal(0);
      expect(await contract.array3(1)).to.equal(0);
      expect(await contract.array3(9)).to.equal(0);

      expect(await contract.array4(0)).to.equal('apple');
      expect(await contract.array4(1)).to.equal('banana');
      expect(await contract.array4(2)).to.equal('carrot');

      expect(await contract.array6(0)).to.equal('');
      expect(await contract.array6(1)).to.equal('');
      expect(await contract.array6(9)).to.equal('');
    });
  });

  describe('Example 2', () => {

    it('demonstrates functions', async () => {
      const Contract = await ethers.getContractFactory('Arrays2');
      let contract = await Contract.deploy();

      // array is empty at the start
      expect(await contract.length()).to.equal(0);

      // add some items
      await contract.push(1);
      await contract.push(2);
      await contract.push(3);

      // check length after
      expect(await contract.length()).to.equal(3);

      // get the whole array
      let array = await contract.getArray();
      expect(array[0]).to.equal(1);
      expect(array[1]).to.equal(2);
      expect(array[2]).to.equal(3);

      // read items from contract
      expect(await contract.array(0)).to.equal(1);
      expect(await contract.getIndex(0)).to.equal(1);

      // remove last item
      await contract.pop();
      expect(await contract.length()).to.equal(2);

      // delete first item
      await contract.remove(0);
      expect(await contract.length()).to.equal(2); // preserves length
      expect(await contract.array(0)).to.equal(0); // resets to default value

    })
  })

})
