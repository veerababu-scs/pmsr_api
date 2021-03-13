class OrgsController < ApplicationController
	def index
        @orgs = Org.all 
        @ord = Array.new()

        @orgs.each do |item|

            orgs = {
                "Organization Id" => item.id,
                "Organization Name"=>item.org_name
            }

         @ord.push(orgs)
        end

        output = {
            "Organizations Count" => @orgs.count,
            "Organization Details" => @ord
        }
        
        render( json: OrgSerializer.render_info(output), status: 200 )
    end

    def show
        @org = Org.find(params[:id]) rescue nil
        if !@org.nil?
        	orgs = {
                "Organization Id" => @org.id,
                "Organization Name"=>@org.org_name.titleize
            }
        render( json: OrgSerializer.render_info(orgs), status: 200 )
        else
        render( json: OrgSerializer.render_error("Organization Not Found"), status: 422 )
        end
        
    end
end
