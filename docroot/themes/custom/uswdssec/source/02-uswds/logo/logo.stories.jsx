import parse from 'html-react-parser';

import twigTemplate from './logo.twig';
import data from './logo.yml';
import extendedData from './logo--image.yml';
import '../uswds.es6';

const settings = {
  title: 'USWDS/Logo',
  parameters: {
    controls: {
      include: ['site_name', 'site_logo', 'url']
    }
  }
};

const Logo = args => (
  parse(twigTemplate({
    ...args,
  }))
);
Logo.args = {...data };

const LogoImage = args => (
  parse(twigTemplate({
    ...args,
  }))
);
LogoImage.args = {...extendedData };
LogoImage.parameters = {
  docs: {
    storyDescription: "See https://designsystem.digital.gov/components/header/ and https://components.designsystem.digital.gov/components/detail/header--extended.html.",
  },
};

export default settings;
export { Logo, LogoImage };
