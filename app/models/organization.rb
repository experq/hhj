class Organization
  include Mongoid::Document
  include Mongoid::Tree
  include Mongoid::Timestamps

  has_many  :organs, dependent: :delete
  has_many  :eligibility_rule_sets
  has_many  :users, inverse_of: :university

  before_validation :downcase_key
  validate :validate_key_uniqueness_for_root_organizations

  field     :name, localize: true
  field     :key, type: String
  field     :recommendations_threshold, type: Integer #inclusive minimal number of recommendations required for PositionApplication to be approved

  def tree_hash
    serializable_hash.merge(children: children.map(&:serializable_hash))
  end

  def self.university_by_key(key)
    roots.where(key: key).first
  end

  protected

  def downcase_key
    self.key.downcase! unless key.blank?
  end

  def validate_key_uniqueness_for_root_organizations
    return unless parent.nil?

    if key.blank?
      errors.add(:key, errors.generate_message(:key, :blank, name: name))
    else
      Organization.where(key: key, :_id.ne => _id).each do |other|
        errors.add(
          :key, errors.generate_message(
            :key, :taken, name: name, key: key, other: other.name))
      end
    end
  end

end
