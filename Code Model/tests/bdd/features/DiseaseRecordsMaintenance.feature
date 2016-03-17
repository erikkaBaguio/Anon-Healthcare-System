# Created by erikka at 3/14/16
Feature: Disease Records Maintenance
  As an admin,I want to be able to view all disease records
  and view specific disease
  and add a diease

  Scenario: Admin retrieves disease data successfully
            Given diseases that are already stored in the system
            When the admin retrieve the disease with an id number '1'
            Then I should get a '200' response
            And the following disease details are returned:
              | done      | id | name   |
              | True      | 1  | Dengue |

  Scenario: Admin retrieves disease records successfully
            Given disease records that are already stored in the system
            When the admin retrieve the disease record with an id number '1'
            Then I should get a '200' response
            And the following disease record details are returned:
              |  done   | id | disease_id  | symptom_id  |
              |  True   | 1  | 1           | 3           |