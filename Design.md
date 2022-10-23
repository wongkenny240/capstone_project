# Property Token

## Datatypes

| data field | data type | compulsory | private/public |description|
|------------|-----------|------------|----------------|----------------|
| latitiude      | int          |            |                |location|
| longtitude           | int          |            |                |location|
| floor           |   string        |            |                |floor of the real estate|
| block           |   string        |            |                |block of the real estate|
| flat           |    string       |            |                |flat number/letter of the real estate|
| property address           | string           |            |                | physical address of the real estate|
| target selling price           |   int        |            |                | target selling price of the real estate (set by owner) |
| owner address           |  address         |            |                | wallet address of owner |
| collateralised           |  bool         |            |                | whether the property token has been collateralised to borrow money|
| state           | state          |            |                | state of the property (Activated, Pending, In Transaction, Sold) |

## Function
* mint/ createtoken
* set target price

| function | description | private/public |
|----------|-------------|----------------|
|          |             |                |
|          |             |                |
|          |             |                |


## Property Factory

* to create new instances of property
* to view instances of property available

| data field | data type | compulsory | private/public |description|
|------------|-----------|------------|----------------|----------------|
|Properties  | list          |            |    private            | List of properties|

## Function 

| function | description | private/public |
|----------|-------------|----------------|
| createProperty          |             |                |
| propertiesCount          |             |                |
|          |             |                |



# Mortgage Token

