## Property Token

* mint/ create token (i.e. register contract)
* set target price and details of the properties, such as owner and physical address

### Datatypes

| data field | data type | compulsory | private/public |description|
|------------|-----------|------------|----------------|----------------|
| latitiude      | int          |   Y         |                |location|
| longtitude           | int          | Y           |                |location|
| floor           |   string        |    Y        |                |floor of the real estate|
| block           |   string        |     Y       |                |block of the real estate|
| flat           |    string       |      Y      |                |flat number/letter of the real estate|
| property address           | string           | N           |                | physical address of the real estate|
| target selling price           |   int        |  Y          |                | target selling price of the real estate (set by owner) |
| owner address           |  address         |      Y      |   private            | wallet address of owner |
| collateralised           |  bool         |        Y    |   private             | whether the property token has been collateralised to borrow money|
| state           | state          |      Y      |    private            | state of the property (Activated, Pending, In Transaction, Sold) |

### Function


| function | private/public | description |
|----------|-------------|----------------|
| setTargetPrice         |             | set the target selling price of the property               |
| registerContract         |             |   register the property contract on the chain and return the token id to the user             |
|          |             |                |


### Property Repository

* to create new instances of property contracts
* to view instances of property available
* for secondary market of property (trading of property after issuance)

| data field | data type | compulsory | private/public |description|
|------------|-----------|------------|----------------|----------------|
|Properties  | list          |            |    private            | List of properties|

### Function 

| function | private/public | description |
|----------|-------------|----------------|
| createProperty          |             |                |
| propertiesCount          |             |                |
| view property         |             |                |
| createSale         |             | create auction (i.e. sale) of the property                |
| approveAndTransfer         |             | approve and transfer the property   |
| cancelSale         |             | cancel the auction   |
| bidOnSale         |             | submit a bid for the sale, if bid price more than target selling price, sale is completed successfully and the property is transferred to the bidder (buyer), otherwise return to the seller  |

## Mortgage Token

Morgage Applicant (Struct)

| data field | data type | compulsory | private/public |description|
|------------|-----------|------------|----------------|----------------|
| Surname  | string          |            |                | |
| LastName  | string           |            |                | |
| ID No  | string           |            |                | |
| Mobile  | string           |            |                | |
| Email  | string           |            |                | |
| Residential Address  | string           |            |                | |
| Employment Status  | string           |            |                | Employed/Self employed|
| Type of Income | string           |            |                | Regular/ Irregular/ Commission based|