Feature: Creating new call for applications for organ

  Background:
    Given there exists an organ 'Tasa-arvotyöryhmä'
    And I am logged in as a student union employee
    And I am at front page of 'Spartan Teknillinen Yliopisto'
    And I navigate to home page of organ 'Tasa-arvotyöryhmä'

  Scenario: Create a call fails
    When I press 'Avaa uusi paikkahaku'
    And I fill in form 'Avaa uusi paikkahaku toimielimelle':
      |  label                              | value                                                     |
    And I press 'Tallenna'
    Then I should see "Puutteellinen haku"

  Scenario: Create new call and edit it
    When I press 'Avaa uusi paikkahaku'
    And I fill in form 'Avaa uusi paikkahaku toimielimelle':
      |  label                              | value                                                     |
      |  Paikkahaun otsikko                 | Haetaan uusia edustajia Tasa-arvotyöryhmään kaudelle 2013 |
      |  Kuvaus hallopedin työnkuvasta      | Valvoa opiskelijoiden etua tasa-arvon toteutumassa        |
      |  Varsinaisia jäseniä                | 3                                                         |
      |  Varajäseniä                        | 1                                                         |
      |  Haun avaamispäivämäärä             | 2012-01-01                                                |
      |  Haun alkamispäivämäärä             | 2012-01-02                                                |
      |  Haun päättymispäivämäärä           | 2012-01-20                                                |
      |  Toimikauden alkamisaika            | 2012-02-02                                                |
      |  Toimikauden päättymisaika          | 2012-06-30                                                |
      |  Päätöksenteon paikka ja ajankohta  | Yliopiston ohjausryhmän kokous tammikuun lopussa          |
      |  Lisätietoa käsittelijälle          | Ainakin yksi nainen ja yksi mies                          |

    And I press 'EN'
    And I fill in form 'Avaa uusi paikkahaku toimielimelle':
      |  label                                   | value                                                            |
      |  Title for the call for applications     | Call for new representatives for Equality organ in term 2013     |
      |  Halloped's job description              | Lobbying the interests of students in equality                   |
      |  Additional information for the receiver | At least one woman and one man                                   |

    And I press 'Tallenna'

    Then I should see call for application 'Haetaan uusia edustajia Tasa-arvotyöryhmään kaudelle 2013' with description 'Valvoa opiskelijoiden etua tasa-arvon toteutumassa':
      |  label                              | value                                                            |
      |  Toimikausi                         | 02.02.2012 - 30.06.2012                                          |
      |  Haetaan                            | 3 varsinaista jäsentä, yhtä varajäsentä                          |
      |  Haun avaamispäivämäärä             | 01.01.2012                                                       |
      |  Hakuaika                           | 02.01.2012 - 20.01.2012                                          |
      |  Toimikausi                         | 02.02.2012 - 30.06.2012                                          |
      |  Päätöksenteon paikka ja ajankohta  | Yliopiston ohjausryhmän kokous tammikuun lopussa                 |

    And I change language to 'en'
    Then I should see call for application 'Call for new representatives for Equality organ in term 2013' with description 'Lobbying the interests of students in equality':
      |  label                           | value                                                            |
      |  Term                            | 2012-02-02 - 2012-06-30                                          |

    And I change language to 'fi'
    Then I press the edit icon within call details
    And I fill in form 'Muokkaa paikkahakua':
      |  label                              | value                                                     |
      |  Paikkahaun otsikko                 | Haetaan uusia edustajia Tasa-arvotyöryhmään kaudelle 2015 |
      |  Kuvaus hallopedin työnkuvasta      | Valvoa opiskelijoiden etua tasa-arvon toteutumassa        |
      |  Varsinaisia jäseniä                | 4                                                         |
      |  Varajäseniä                        | 1                                                         |
      |  Haun avaamispäivämäärä             | 2012-01-01                                                |
      |  Haun alkamispäivämäärä             | 2012-01-02                                                |
      |  Haun päättymispäivämäärä           | 2012-01-20                                                |
      |  Toimikauden alkamisaika            | 2012-02-02                                                |
      |  Toimikauden päättymisaika          | 2012-06-30                                                |
      |  Päätöksenteon paikka ja ajankohta  | Yliopiston ohjausryhmän kokous tammikuun lopussa          |
      |  Lisätietoa käsittelijälle          | Ainakin yksi nainen ja yksi mies ja koira                 |

    And I press 'EN'
    And I fill in form 'Muokkaa paikkahakua':
      |  label                                   | value                                                            |
      |  Title for the call for applications     | Call for new representatives for Equality organ in term 2013     |
      |  Halloped's job description              | Lobbying the interests of students in equality                   |
      |  Additional information for the receiver | At least one woman and one man and a dog                         |

    And I press 'Tallenna'
    Then I should see call for application 'Haetaan uusia edustajia Tasa-arvotyöryhmään kaudelle 2015'
