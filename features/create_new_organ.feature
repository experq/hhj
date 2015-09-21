Feature: Creating a new organ

  Background:
    Given there exist university organization
    And I am logged in as a member of university staff
    And I am at front page of 'Spartan Teknillinen Yliopisto'

  Scenario: Creating an organ fails
    When I press 'Luo uusi toimielin'
    And I fill in form 'Luo uusi toimielin':
      |  label                           | value                                                            |
    And I press 'Tallenna'
    Then I should see "Puutteellinen toimielin"

  Scenario: Staff member creates new organ
    When I press 'Luo uusi toimielin'
    And I fill in form 'Luo uusi toimielin':
      |  label                           | value                                                            |
      |  Toimielimen nimi                | Tasa-arvotyöryhmä                                                |
      |  Kuvaus toimielimen toiminnasta  | Työryhmä varmistaa tasa-arvon toteutumisen                       |
      |  Toimikauden alkamisaika:        | 2012-01-01                                                       |
      |  Toimikauden päättymisaika:      | 2012-07-01                                                       |
      |  Vastuuhenkilön nimi             | Saima Salminen                                                   |
      |  Vastuuhenkilön sähköpostiosoite | saima@halloped.fi                                                |
      |  Nimityksen tekevä taho          | Dekaani                                                          |
      |  Valitse organisaatioyksikkö     | Luonnontieteellinen tiedekunta/Fysiikan laitos+Lakisääteinen     |

    And I press 'EN'
    And I fill in form 'Luo uusi toimielin':
      |  label                             | value                                                            |
      |  Organ name                        | Equality organ                                                   |
      |  Description on organ's operations | Organ assures fulfilling of equality                             |

    And I press 'Tallenna'

    Then I should see introduction of organ 'Tasa-arvotyöryhmä' with description 'Työryhmä varmistaa tasa-arvon toteutumisen':
      |  label                           | value                                                            |
      |  Toimikausi                      | 01.01.2012 - 01.07.2012                                          |
      |  Vastuuhenkilö                   | Saima Salminen                                                   |
      |  Organisaatioyksikkö             | Luonnontieteellinen tiedekunta - Fysiikan laitos                 |

    And I change language to 'en'
    Then I should see introduction of organ 'Equality organ' with description 'Organ assures fulfilling of equality':
      |  label                           | value                                                            |
      |  Term                            | 2012-01-01 - 2012-07-01                                          |
      |  Person in charge                | Saima Salminen                                                   |


Scenario: Staff member creates new unofficial organ directly under university
    When I press 'Luo uusi toimielin'
    And I fill in form 'Luo uusi toimielin':
      |  label                           | value                                                            |
      |  Toimielimen nimi                | Opintoneuvonta                                                   |
      |  Valitse organisaatioyksikkö     | +Ei lakisääteinen                                                |

    And I press 'Tallenna'

    Then I should see introduction of organ 'Opintoneuvonta' with description '':
      |  label                           | value                                                            |
      |  Organisaatioyksikkö             |                                                                  |

Scenario: Description supports markdown
    When I press 'Luo uusi toimielin'
    And I fill in form 'Luo uusi toimielin':
      |  label                           | value                                                            |
      |  Toimielimen nimi                | Merkkialas elin                                                  |
      |  Kuvaus toimielimen toiminnasta  | ### Markdown Otsikko                                             |

    And I press 'Tallenna'

    Then I should see level 3 header "Markdown Otsikko"

