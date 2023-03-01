import parse from 'html-react-parser';

import twigTemplate from './navbar.twig';
import '../uswds.es6';
import logoData from '../logo/logo--image.yml';

const settings = {
  title: 'USWDS/Nav Bar',
  parameters: {
    docs: {
      description: {
        component: "Part of the USWDS Header component.",
      },
    },
    controls: {
      include: ['site_name', 'site_logo', 'url']
    }
  }
};

const NavBar = args => (
  parse(twigTemplate({
    ...args,
  }))
);

NavBar.args = { ...logoData };

export default settings;
export { NavBar };
