class InterventionType < ActiveRecord::Base
  has_many :interventions

  def self.seed_somerville_intervention_types
    InterventionType.create([
      { name: "X-Block" },
      { name: "Teaching plan" },
      { name: "Phone call" },
      { name: "Reading tutor" },
      { name: "Math tutor" },
      { name: "After-School Tutoring (ATP)"}
    ])
  end

  def self.atp
    find_by_name("After-School Tutoring (ATP)")
  end

end
