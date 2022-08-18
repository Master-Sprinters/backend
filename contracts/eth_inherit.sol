// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

/* modifier
event
openzeppelin 
*/

contract Eth_Inherit {

    address private admin; 

    enum Roles{ ADMIN, PARENT, CHILD, UNREGISTERED }

    // isValue yerine 0 

    constructor()  {
        admin = msg.sender;
    }

    struct Parent {
        address payable _address;
        string name;
        string surname;
        // sonradan mapping yapabiliriz
        address[] childrenAddresses;
        // kişinin sistemde olup olmadığını gösteren bool
    }

    struct Child {
        address payable _address;
        string name;
        string surname;
        // releasetime veya birthdate
        uint256 releaseTime;
        uint256 balance;
        address parentAddress;
    }

    mapping (address => Parent) private parents;
    mapping (address => Child) private children;
    address[] private parentsArray;

    function addParent(address payable _address, string memory name, string memory surname) public {
        require(getRole(msg.sender) != Roles.CHILD && getRole(msg.sender) != Roles.PARENT);
        
        Parent storage parentObject = parents[_address]; 
        require((parents[_address]._address != address(0)), "Parent already in system.");
        parentObject._address = _address;
        parentObject.name = name;
        parentObject.surname = surname;
        parentsArray.push(_address);
    }

    function addChild(address payable childAddress, string memory name, string memory surname) public {
        // releaseTime ve balance başka metotta
        // sadece parent yapabilir
        require(getRole(msg.sender) == Roles.PARENT, "You are not a parent.");
        
        // metodu çağıran ebeveynin adresini al
        address parentAddress = msg.sender;

        // metodu çağıran ebeveyn sistemde var mı?
        require(parents[parentAddress]._address == address(0), "Parent not in system.");

        // eklenecek çocuk sistemde var mı?        
        require(!(children[childAddress]._address != address(0)), "Child already in system.");

        Child storage childObject = children[childAddress];
        childObject._address = childAddress;
        childObject.name = name;
        childObject.surname = surname;
        childObject.parentAddress = parentAddress;
        parents[parentAddress].childrenAddresses.push(childAddress);
    }

    function getParent() public view returns(Parent memory result) {
        if(getRole(msg.sender) == Roles.PARENT) {
            result = parents[msg.sender];
        } else {
            result = parents[children[msg.sender].parentAddress] ;
        }
    }

    function getAllParents() public view returns(Parent[] memory result) {
        // Sadece admin icin, butun parentlari doner
        // !!!!!!!!!!!!!! aslında Roles.ADMIN yerine direkt admin'in adresine eşitleyebiliriz
        require(getRole(msg.sender) == Roles.ADMIN, "You are not an admin.");
        result = new Parent[](parentsArray.length); 
        for (uint i = 0; i < parentsArray.length; i++) {
            result[i] = parents[parentsArray[i]];
        }
    }
    
    function getChild() public view returns(Child memory result) {
        // EKLE: çocuk sadece kendi bilgilerini görebilmeli parent ve admin bütün çocukların bilgilerini görebilmeli
        Child storage child = children[msg.sender]; 
        result = child;
    }

    // smart contracta para yollama metodu
    function sendMoneytoContract(address childAddress, uint256 releaseTime) public payable {
        address owner = msg.sender;
        Child storage _child = children[childAddress];
        _child.releaseTime = releaseTime;
        _child.balance= msg.value;
        
        /* 
            EKLE: 
            çocuk sistemde var mı?
            releaseTime kontrolü (tarih ileri bir tarih mi?) 
            gönderilen para yeterli mi? 
        */

    }

    // çocuk sonradan parent olursa aşağıdaki sıraya göre ZATEN ilk olarak parent dönecektir !
    function getRole(address roleAddress) public view returns(Roles) {
        if (roleAddress == admin) {
            return(Roles.ADMIN);
        }
        else if (parents[roleAddress]._address != address(0)) {
            return(Roles.PARENT);
        }
        else if (children[roleAddress]._address != address(0)) {
            return(Roles.CHILD);
        }
        else {
            return(Roles.UNREGISTERED);
        }
    }
    
    // smart contracttan para çekme metotları

    function childWithdraw() public {
        address personAddress = payable(msg.sender);
        require(getRole(personAddress) == Roles.CHILD, "User not a child.");
        Child storage childObject = children[personAddress];
        
        // EKLE: if tarih geçmiş ise
        if(true){
            (bool sent, bytes memory data) = personAddress.call{value: childObject.balance}("");
            require(sent, "Failed to send Ether");
            // balance değişkenini sıfırlıyor
            delete childObject.balance;
            // bunu yapınca getRole artık çocuğu algılamıyor
            delete childObject._address;
        }
    }

    function parentWithdraw(uint amount) public {
        // çocuktaki çektiği para yeterli olmalı
        address personAddress = payable(msg.sender);
        (bool sent, bytes memory data) = personAddress.call{value: amount}("");
        require(sent, "Failed to send Ether");
    }
}
