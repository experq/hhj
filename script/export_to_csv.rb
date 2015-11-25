puts PositionApplication.where(:created_at.gte => '2015-05-04').select { |pa| pa.call && pa.call.workflow == :workflow_administration_election}.map { |pa|
  u = pa.user
  row = [u.first_name, u.last_name, u.email, pa.position, "'#{pa.call.title}'", "'#{pa.custom['degree']}'", pa.custom['available'], u.edu_data['A_PROGRAM']]
  pa.recommendations.each do |r|
    u = r.user
    row += [u.first_name, u.last_name, u.email, u.edu_data['A_PROGRAM']]
  end
  row.join(",")
}.join("\n")
