#Haun Avaamispäivämäärä 16.11.
# Haun Aloituspäivämäärä 16.11.
#Lopetuspäivämäärä 25.11. kello 12:00
#Toimielimien kausiksi 1.1.2016 – 31.12.2017

@test_finding = false

def create_call(organ_finnish, member_amount)
  organ = Organ.find_by('name.fi' => organ_finnish, 'status' => :visible)
  call_titles = Hash[organ.name_translations.map { |k,n| [k, "#{n} 2015/2"] }]
  unless @test_finding
    Call.create!(member_amount: member_amount,
                 deputy_amount: member_amount,
                 title: call_titles,
                 workflow: :workflow_administration_election,
                 organ_id: organ.id,
                 date_start: Date.parse('2015-11-16'),
                 date_open: Date.parse('2015-11-16'),
                 date_end: Date.parse('2015-11-25'),
                 term_start: Date.parse('2016-01-01'),
                 term_end: Date.parse('2017-12-31')
    )
  end
end

#tiedekuntaneuvostot

teo_finnish = "Teologisen tiedekunnan tiedekuntaneuvosto"
create_call(teo_finnish, 3)

hum_finnish = "Humanistisen tiedekunnan tiedekuntaneuvosto"
create_call(hum_finnish, 5)

valt_names = "Valtiotieteellisen tiedekunnan tiedekuntaneuvosto"
create_call(valt_names, 5)

#laitosneuvostot

filo_inst_names = "Filosofian, historian, kulttuurin ja taiteiden tutkimuksen laitoksen laitosneuvosto"
create_call(filo_inst_names, 4)

create_call('Yliopistokollegio – Teologinen tiedekunta', 1)
create_call('Yliopistokollegio – Humanistinen tiedekunta', 2)
